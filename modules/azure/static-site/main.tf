terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.0.0"
    }
  }
}

# Azure Static Web App
resource "azurerm_static_site" "example" {
  name                = var.static_site_name
  resource_group_name = var.static_site_rsg
  location            = var.static_site_location
}