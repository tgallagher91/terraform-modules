output "storage_account_id" {
  value       = azurerm_storage_account.example.id
  description = "The ID of the Azure Storage Account"
}

output "storage_account_name" {
  value       = azurerm_storage_account.example.name
  description = "The name of the Azure Storage Account"
}

output "storage_account_primary_access_key" {
  value       = azurerm_storage_account.example.primary_access_key
  description = "The primary access key for the Azure Storage Account"
}

output "storage_account_primary_connection_string" {
  value       = azurerm_storage_account.example.primary_connection_string
  description = "The primary connection string for the Azure Storage Account"
}

output "storage_account_primary_blob_endpoint" {
  value       = azurerm_storage_account.example.primary_blob_endpoint
  description = "The primary blob endpoint for the Azure Storage Account"
}

output "storage_account_location" {
  value       = azurerm_storage_account.example.location
  description = "The location of the Azure Storage Account"
}
