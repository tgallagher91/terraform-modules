# Output for Azure App Service Plan
output "app_service_plan_id" {
  value = azurerm_app_service_plan.example.id
  description = "The ID of the App Service Plan"
}

# Output for Azure Web App
output "web_app_default_site_hostname" {
  value = azurerm_app_service.example.default_site_hostname
  description = "The default hostname of the Web App"
}

# Output for Azure Static Web App
output "static_site_default_hostname" {
  value = azurerm_static_site.example.default_hostname
  description = "The default hostname of the Static Web App"
}

# Output for Azure User Assigned Identity
output "user_assigned_identity_id" {
  value = azurerm_user_assigned_identity.example.id
  description = "The ID of the User Assigned Identity"
}

# Output for Azure Cosmos DB Account
output "cosmosdb_account_endpoint" {
  value = azurerm_cosmosdb_account.example.endpoint
  description = "The endpoint of the Cosmos DB Account"
}

# Output for Azure Storage Account
output "storage_account_primary_blob_endpoint" {
  value = azurerm_storage_account.example.primary_blob_endpoint
  description = "The primary blob endpoint of the Storage Account"
}

# Output for Azure Function App
output "function_app_default_hostname" {
  value = azurerm_function_app.example.default_hostname
  description = "The default hostname of the Function App"
}
