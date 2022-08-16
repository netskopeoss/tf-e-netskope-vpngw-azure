variable "vnet_rg_name" {
  type        = string
  description = "The virtual network (vnet) Resource Group Name."
}

variable "vnet_name" {
  type        = string
  description = "The virtual network (vnet) name where the vpn gateway will be deployed."
}

variable "snet_name" {
  type        = string
  description = "Subnet Name of the virtual network (vnet) to deploy vpn gateway. MUST have a subnet with name GatewaySubnet with an address range of /27."
  default = "GatewaySubnet"
}

variable "dpt_prefix" {
  type        = string
  description = "Department prefix to use to label resources in this deployment."
  default     = "NS"
}

variable "env_prefix" {
  type        = string
  description = "The environment prefix details where all resources should be created e.g. Production (PRD) etc."
  default     = "PRD"
}

variable "resource_prefix" {
  type        = string
  description = "The resource Prefix to use when naming the objects."
  default     = "VPN"
}

variable "shared_key" {
  type        = string
  description = "The shared IPSec key to use for tunnel configuration."
}

variable "vpngw_sku" {
  type        = string
  description = "Configuration of the size and capacity of the virtual network gateway. Minimum SKU VPNGW2 is required for Custom IPsec Policy."
  default     = "VpnGw2"
}

variable "tunnel_peers" {
  type        = map(string)
  description = "IP addresses of two Netskope POPs. Set these values to the nearest POP as per your deployment. Complete IP address list is available in netskope UI"
}
variable "epot_config" {
  type        = string
  description = "Is this deployment only for Explicit over Proxy Tunnel Configuration?"
  default     = "No"
  validation {
    condition     = contains(["Yes", "No"], (var.epot_config))
    error_message = "Must be either set to Yes or No"
  }
}