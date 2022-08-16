resource "azurerm_public_ip" "vpngw_ip" {
  name                = format("%s%s%s%s%s%s", var.dpt_prefix, var.env_prefix, "-", var.resource_prefix, "-", "pip")
  resource_group_name = var.vnet_rg_name
  location            = data.azurerm_resource_group.vn_rg.location
  sku                 = "Standard"
  allocation_method   = "Static"
}