output "static_web_app_id" {
  value       = azurerm_static_site.example.id
  description = "The ID of the Azure Static Web App"
}

output "static_web_app_name" {
  value       = azurerm_static_site.example.name
  description = "The name of the Azure Static Web App"
}

output "static_web_app_default_hostname" {
  value       = azurerm_static_site.example.default_hostname
  description = "The default hostname of the Azure Static Web App"
}

output "static_web_app_location" {
  value       = azurerm_static_site.example.location
  description = "The location of the Azure Static Web App"
}

output "static_web_app_resource_group_name" {
  value       = azurerm_static_site.example.resource_group_name
  description = "The name of the resource group containing the Azure Static Web App"
}
