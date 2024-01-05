output "function_app_id" {
  value       = azurerm_function_app.example.id
  description = "The ID of the Azure Function App"
}

output "function_app_default_hostname" {
  value       = azurerm_function_app.example.default_hostname
  description = "The default hostname of the Azure Function App"
}

output "function_app_outbound_ip_addresses" {
  value       = azurerm_function_app.example.outbound_ip_addresses
  description = "The outbound IP addresses of the Azure Function App"
}

output "function_app_possible_outbound_ip_addresses" {
  value       = azurerm_function_app.example.possible_outbound_ip_addresses
  description = "The possible outbound IP addresses of the Azure Function App"
}
