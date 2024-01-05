terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.0.0"
    }
  }
}

# Azure App Service Plan
resource "azurerm_app_service_plan" "example" {
  name                = var.app_service_name
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  sku {
    tier = var.tier_type
    size = var.size
  }
}

# Azure Web App
resource "azurerm_app_service" "example" {
  name                = var.web_app_name
  location            = var.app_service_location
  resource_group_name = var.app_service_rsg
  app_service_plan_id = var.app_spid
}

# Azure Static Web App
resource "azurerm_static_site" "example" {
  name                = var.static_site_name
  resource_group_name = var.static_site_rsg
  location            = var.static_site_location
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

# Azure Storage Account
resource "azurerm_storage_account" "example" {
  name                     = var.storage_name
  resource_group_name      = var.storage_rsg
  location                 = var.storage_location
  account_tier             = var.account_tier
  account_replication_type = var.replication_type
}

# Azure Function App
resource "azurerm_function_app" "example" {
  name                       = var.function_app_name
  location                   = var.function_app_location
  resource_group_name        = var.function_app_rsg
  app_service_plan_id        = var.function_app_spid
  storage_account_name       = var.storage_account_name
  storage_account_access_key = var.storage_access_key
}