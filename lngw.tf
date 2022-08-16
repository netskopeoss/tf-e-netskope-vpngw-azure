resource "azurerm_local_network_gateway" "pop1" {
  count               = var.epot_config == "No" ? 1 : 0
  name                = format("%s%s%s%s%s%s", var.dpt_prefix, var.env_prefix, "-", var.resource_prefix, "-", "pop1")
  resource_group_name = azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.vn_rg.location
  gateway_address     = var.tunnel_peers.pop1
  address_space       = ["0.0.0.0/1", "128.0.0.0/1"]
}

resource "azurerm_local_network_gateway" "pop2" {
  count               = var.epot_config == "No" ? 1 : 0
  name                = format("%s%s%s%s%s%s", var.dpt_prefix, var.env_prefix, "-", var.resource_prefix, "-", "pop2")
  resource_group_name = azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.vn_rg.location
  gateway_address     = var.tunnel_peers.pop2
  address_space       = ["0.0.0.0/1", "128.0.0.0/1"]
}

resource "azurerm_local_network_gateway" "ep_pop1" {
  count               = var.epot_config == "Yes" ? 1 : 0
  name                = format("%s%s%s%s%s%s", var.dpt_prefix, var.env_prefix, "-", var.resource_prefix, "-", "pop1")
  resource_group_name = azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.vn_rg.location
  gateway_address     = var.tunnel_peers.pop1
  address_space       = ["163.116.128.80/32", "163.116.128.81/32"]
}

resource "azurerm_local_network_gateway" "ep_pop2" {
  count               = var.epot_config == "Yes" ? 1 : 0
  name                = format("%s%s%s%s%s%s", var.dpt_prefix, var.env_prefix, "-", var.resource_prefix, "-", "pop2")
  resource_group_name = azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.vn_rg.location
  gateway_address     = var.tunnel_peers.pop2
  address_space       = ["163.116.128.80/32", "163.116.128.81/32"]
}
