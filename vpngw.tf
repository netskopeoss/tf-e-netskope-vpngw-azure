resource "azurerm_virtual_network_gateway" "vpngw" {
  name                = format("%s%s%s%s%s%s", var.dpt_prefix, var.env_prefix, "-", var.resource_prefix, "-", "gw")
  location            = data.azurerm_resource_group.vn_rg.location
  resource_group_name = var.vnet_rg_name

  type     = "Vpn"
  vpn_type = "RouteBased"

  active_active = false
  enable_bgp    = false
  sku           = var.vpngw_sku

  ip_configuration {
    name                          = "vnetGatewayConfig"
    public_ip_address_id          = azurerm_public_ip.vpngw_ip.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = data.azurerm_subnet.snet.id
  }
}

resource "azurerm_virtual_network_gateway_connection" "pop1" {
  count               = var.epot_config == "No" ? 1 : 0
  name                = format("%s%s%s%s%s%s", var.dpt_prefix, var.env_prefix, "-", var.resource_prefix, "-", "con1")
  location            = data.azurerm_resource_group.vn_rg.location
  resource_group_name = var.vnet_rg_name

  type                       = "IPsec"
  virtual_network_gateway_id = azurerm_virtual_network_gateway.vpngw.id
  local_network_gateway_id   = azurerm_local_network_gateway.pop1[count.index].id

  shared_key = var.shared_key
  ipsec_policy {
    dh_group         = "DHGroup2048"
    ike_encryption   = "AES256"
    ike_integrity    = "SHA256"
    ipsec_encryption = "GCMAES256"
    ipsec_integrity  = "GCMAES256"
    pfs_group        = "PFS2048"
    sa_datasize      = "102400000"
    sa_lifetime      = "7200"
  }
}

resource "azurerm_virtual_network_gateway_connection" "pop2" {
  count               = var.epot_config == "No" ? 1 : 0
  name                = format("%s%s%s%s%s%s", var.dpt_prefix, var.env_prefix, "-", var.resource_prefix, "-", "con2")
  location            = data.azurerm_resource_group.vn_rg.location
  resource_group_name = var.vnet_rg_name

  type                       = "IPsec"
  virtual_network_gateway_id = azurerm_virtual_network_gateway.vpngw.id
  local_network_gateway_id   = azurerm_local_network_gateway.pop2[count.index].id

  shared_key = var.shared_key
  ipsec_policy {
    dh_group         = "DHGroup2048"
    ike_encryption   = "AES256"
    ike_integrity    = "SHA256"
    ipsec_encryption = "GCMAES256"
    ipsec_integrity  = "GCMAES256"
    pfs_group        = "PFS2048"
    sa_datasize      = "102400000"
    sa_lifetime      = "7200"
  }
}

resource "azurerm_virtual_network_gateway_connection" "ep_pop1" {
  count               = var.epot_config == "Yes" ? 1 : 0
  name                = format("%s%s%s%s%s%s", var.dpt_prefix, var.env_prefix, "-", var.resource_prefix, "-", "con1")
  location            = data.azurerm_resource_group.vn_rg.location
  resource_group_name = var.vnet_rg_name

  type                       = "IPsec"
  virtual_network_gateway_id = azurerm_virtual_network_gateway.vpngw.id
  local_network_gateway_id   = azurerm_local_network_gateway.ep_pop1[count.index].id

  shared_key = var.shared_key
  ipsec_policy {
    dh_group         = "DHGroup2048"
    ike_encryption   = "AES256"
    ike_integrity    = "SHA256"
    ipsec_encryption = "GCMAES256"
    ipsec_integrity  = "GCMAES256"
    pfs_group        = "PFS2048"
    sa_datasize      = "102400000"
    sa_lifetime      = "7200"
  }
}

resource "azurerm_virtual_network_gateway_connection" "ep_pop2" {
  count               = var.epot_config == "Yes" ? 1 : 0
  name                = format("%s%s%s%s%s%s", var.dpt_prefix, var.env_prefix, "-", var.resource_prefix, "-", "con2")
  location            = data.azurerm_resource_group.vn_rg.location
  resource_group_name = var.vnet_rg_name

  type                       = "IPsec"
  virtual_network_gateway_id = azurerm_virtual_network_gateway.vpngw.id
  local_network_gateway_id   = azurerm_local_network_gateway.ep_pop2[count.index].id

  shared_key = var.shared_key
  ipsec_policy {
    dh_group         = "DHGroup2048"
    ike_encryption   = "AES256"
    ike_integrity    = "SHA256"
    ipsec_encryption = "GCMAES256"
    ipsec_integrity  = "GCMAES256"
    pfs_group        = "PFS2048"
    sa_datasize      = "102400000"
    sa_lifetime      = "7200"
  }
}