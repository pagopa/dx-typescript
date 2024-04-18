data "azurerm_container_app_environment" "runner" {
  name                = local.container_app_environment.name
  resource_group_name = local.container_app_environment.resource_group_name
}

data "azurerm_key_vault" "kv" {
  name                = local.key_vault.name
  resource_group_name = local.key_vault.resource_group_name
}
