terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.0.0"
    }
  }
}

resource "azurerm_user_assigned_identity" "example" {
  resource_group_name = var.assigned_identity_rsg
  location            = var.user_assigned_location
  name                = var.assigned_identity_name
}

resource "azurerm_cosmosdb_account" "example" {
  name                  = var.cosmos_name
  location              = var.cosmos_location
  resource_group_name   = var.cosmos_rsg_name
  default_identity_type = join("=", ["UserAssignedIdentity", azurerm_user_assigned_identity.example.id])
  offer_type            = var.cosmos_offer_type
  kind                  = var.cosmos_db_kind
}