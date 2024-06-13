resource "azurerm_resource_group" "rg_common" {
  name     = format("%s-common-rg-01", local.project)
  location = local.location

  tags = local.tags
}