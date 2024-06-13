locals {
  apim_autoscale = {
    enabled                       = true
    default_instances             = 1
    minimum_instances             = 1
    maximum_instances             = 2
    scale_out_capacity_percentage = 50
    scale_out_time_window         = "PT10M"
    scale_out_value               = "2"
    scale_out_cooldown            = "PT45M"
    scale_in_capacity_percentage  = 30
    scale_in_time_window          = "PT30M"
    scale_in_value                = "1"
    scale_in_cooldown             = "PT30M"
  }
  apim_alerts_enabled = true
}

data "azurerm_key_vault_secret" "apim_publisher_email" {
  name         = "apim-publisher-email"
  key_vault_id = module.key_vault.id
}

# APIM subnet
module "apim_snet" {
  source               = "git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet?ref=v8.21.0"
  name                 = format("%s-apim-snet-01", local.project)
  resource_group_name  = azurerm_resource_group.rg_common.name
  virtual_network_name = module.vnet_common.name
  address_prefixes     = ["10.0.1.0/24"]

  private_endpoint_network_policies_enabled = true

  service_endpoints = [
    "Microsoft.Web",
  ]
}

resource "azurerm_network_security_group" "nsg_apim" {
  name                = format("%s-apim-nsg-01", local.project)
  resource_group_name = azurerm_resource_group.rg_common.name
  location            = azurerm_resource_group.rg_common.location

  security_rule {
    name                       = "managementapim"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3443"
    source_address_prefix      = "ApiManagement"
    destination_address_prefix = "VirtualNetwork"
  }

  tags = local.tags
}

resource "azurerm_subnet_network_security_group_association" "snet_nsg" {
  subnet_id                 = module.apim_snet.id
  network_security_group_id = azurerm_network_security_group.nsg_apim.id
}

resource "azurerm_public_ip" "public_ip_apim" {
  name                = format("%s-apim-pip-01", local.project)  
  resource_group_name = azurerm_resource_group.rg_common.name
  location            = azurerm_resource_group.rg_common.location
  allocation_method   = "Static"
  sku                 = "Standard"
  domain_name_label   = "apimdx"
  zones               = ["1", "2", "3"]

  tags = local.tags
}

# ###########################
# ## Api Management (apim) ##
# ###########################
module "apim_dx" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management?ref=v8.21.0"

  subnet_id                 = module.apim_snet.id
  location                  = azurerm_resource_group.rg_common.location
  name                      = format("%s-apim-01", local.project)
  resource_group_name       = azurerm_resource_group.rg_common.name
  publisher_name            = "DX"
  publisher_email           = data.azurerm_key_vault_secret.apim_publisher_email.value
  notification_sender_email = data.azurerm_key_vault_secret.apim_publisher_email.value
  sku_name                  = "Developer_1"
  virtual_network_type      = "Internal"
  zones                     = ["1", "2"]

  public_ip_address_id = azurerm_public_ip.public_ip_apim.id

  # not used at the moment
  redis_connection_string = null # module.redis_apim.primary_connection_string
  redis_cache_id          = null # module.redis_apim.id

  # This enables the Username and Password Identity Provider
  sign_up_enabled = false

  hostname_configuration = {
    proxy = [
      {
        # dx-d-apim-api.azure-api.net
        default_ssl_binding = false
        host_name           = format("%s-apim-api.azure-api.net", local.project)
        key_vault_id        = null
      },
    ]
    developer_portal = null
    management       = null
    portal           = null
  }

  application_insights = {
    enabled             = true
    instrumentation_key = azurerm_application_insights.application_insights.instrumentation_key
  }

  lock_enable = false # no lock

  autoscale = local.apim_autoscale

  alerts_enabled = local.apim_alerts_enabled

  action = [
    {
      action_group_id    = azurerm_monitor_action_group.quarantine_error_action_group.id
      webhook_properties = null
    }
  ]

  # metrics docs
  # https://docs.microsoft.com/en-us/azure/azure-monitor/essentials/metrics-supported#microsoftapimanagementservice
  metric_alerts = {
    capacity = {
      description   = "Apim used capacity is too high. Runbook: https://pagopa.atlassian.net/wiki/spaces/IC/pages/791642113/APIM+Capacity"
      frequency     = "PT5M"
      window_size   = "PT5M"
      severity      = 1
      auto_mitigate = true

      criteria = [{
        metric_namespace       = "Microsoft.ApiManagement/service"
        metric_name            = "Capacity"
        aggregation            = "Average"
        operator               = "GreaterThan"
        threshold              = 60
        skip_metric_validation = false
        dimension              = []
      }]
      dynamic_criteria = []
    }

    duration = {
      description   = "Apim abnormal response time"
      frequency     = "PT5M"
      window_size   = "PT5M"
      severity      = 2
      auto_mitigate = true

      criteria = []

      dynamic_criteria = [{
        metric_namespace         = "Microsoft.ApiManagement/service"
        metric_name              = "Duration"
        aggregation              = "Average"
        operator                 = "GreaterThan"
        alert_sensitivity        = "High"
        evaluation_total_count   = 2
        evaluation_failure_count = 2
        skip_metric_validation   = false
        ignore_data_before       = "2021-01-01T00:00:00Z" # sample data
        dimension                = []
      }]
    }

    requests_failed = {
      description   = "Apim abnormal failed requests"
      frequency     = "PT5M"
      window_size   = "PT5M"
      severity      = 2
      auto_mitigate = true

      criteria = []

      dynamic_criteria = [{
        metric_namespace         = "Microsoft.ApiManagement/service"
        metric_name              = "Requests"
        aggregation              = "Total"
        operator                 = "GreaterThan"
        alert_sensitivity        = "High"
        evaluation_total_count   = 2
        evaluation_failure_count = 2
        skip_metric_validation   = false
        ignore_data_before       = "2021-01-01T00:00:00Z" # sample data
        dimension = [{
          name     = "BackendResponseCode"
          operator = "Include"
          values   = ["5xx"]
        }]
      }]
    }
  }

  tags = local.tags
}