output "web_app_id" {
  value       = azurerm_app_service.example.id
  description = "The ID of the Azure Web App"
}

output "web_app_default_site_hostname" {
  value       = azurerm_app_service.example.default_site_hostname
  description = "The default hostname of the Azure Web App"
}

output "web_app_outbound_ip_addresses" {
  value       = azurerm_app_service.example.outbound_ip_addresses
  description = "The outbound IP addresses of the Azure Web App"
}
