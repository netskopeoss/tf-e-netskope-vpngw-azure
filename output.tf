output "public_ip_address" {
  description = "Azure VPNGW IP address to Use in IPSec Configuration"
  value       = azurerm_public_ip.vpngw_ip.ip_address
}