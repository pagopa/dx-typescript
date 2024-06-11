module "vnet_common" {
  source              = "git::https://github.com/pagopa/terraform-azurerm-v3.git//virtual_network?ref=v8.21.0"
  name                = "${local.project}-vnet-common"
  location            = azurerm_resource_group.rg_common.location
  resource_group_name = azurerm_resource_group.rg_common.name
  address_space       = ["10.0.0.0/16"]
  ddos_protection_plan = {
    id     = "/subscriptions/0da48c97-355f-4050-a520-f11a18b8be90/resourceGroups/sec-p-ddos/providers/Microsoft.Network/ddosProtectionPlans/sec-p-ddos-protection"
    enable = true
  }

  tags = local.tags
}