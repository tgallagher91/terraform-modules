terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.0.0"
    }
  }
}

# Azure Storage Account
resource "azurerm_storage_account" "example" {
  name                     = var.storage_name
  resource_group_name      = var.storage_rsg
  location                 = var.storage_location
  account_tier             = var.account_tier
  account_replication_type = var.replication_type
}