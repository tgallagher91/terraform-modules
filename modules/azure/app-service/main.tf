terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.0.0"
    }
  }
}

# Azure Web App
resource "azurerm_app_service" "example" {
  name                = var.web_app_name
  location            = var.app_service_location
  resource_group_name = var.app_service_rsg
  app_service_plan_id = var.app_spid
}