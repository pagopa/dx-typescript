resource "azurerm_resource_group" "rg_common" {
  name     = format("%s-rg-common", local.project)
  location = local.location

  tags = local.tags
}