# Log Analytics workspace
resource "azurerm_log_analytics_workspace" "log_analytics_workspace" {
  name                = format("%s-common-log-01", local.project)
  location            = azurerm_resource_group.rg_common.location
  resource_group_name = azurerm_resource_group.rg_common.name
  sku                 = "Free"
  retention_in_days   = 7
  daily_quota_gb      = 0.5

  tags = local.tags
}

# Application insights
resource "azurerm_application_insights" "application_insights" {
  name                = format("%s-common-appi-01", local.project)
  location            = azurerm_resource_group.rg_common.location
  resource_group_name = azurerm_resource_group.rg_common.name
  disable_ip_masking  = true
  application_type    = "other"

  workspace_id = azurerm_log_analytics_workspace.log_analytics_workspace.id

  tags = local.tags
}

data "azurerm_key_vault_secret" "alert_quarantine_error_notification_slack" {
  name         = "alert-error-quarantine-notification-slack"
  key_vault_id = module.key_vault.id
}

resource "azurerm_monitor_action_group" "quarantine_error_action_group" {
  resource_group_name = azurerm_resource_group.rg_common.name
  name                = replace(format("%s-quarantine-ag-01", local.project), "-", "")
  short_name          = replace(format("%s-qerr-ag", local.project), "-", "")

  email_receiver {
    name                    = "slack"
    email_address           = data.azurerm_key_vault_secret.alert_quarantine_error_notification_slack.value
    use_common_alert_schema = true
  }

  tags = local.tags
}