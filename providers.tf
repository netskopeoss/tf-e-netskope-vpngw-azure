provider "azurerm" {
  # The "feature" block is required for AzureRM provider 2.x. 
  # If you are using version 1.x, the "features" block is not allowed.
  #subscription_id = ""
  #tenant_id       = ""
#  version = "=2.40.0"
  features {}
}