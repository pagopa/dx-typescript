resource "azurerm_resource_group" "sec_rg" {
  name     = format("%s-sec-rg-01", local.project)
  location = local.location

  tags = local.tags
}

module "key_vault" {
  source                     = "git::https://github.com/pagopa/terraform-azurerm-v3.git//key_vault?ref=v8.21.0"
  name                       = format("%s-common-kv-01", local.project)
  location                   = azurerm_resource_group.sec_rg.location
  resource_group_name        = azurerm_resource_group.sec_rg.name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days = 15
  lock_enable                = false

  tags = local.tags
}