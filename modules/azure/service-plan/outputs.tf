output "app_service_plan_id" {
  value       = azurerm_app_service_plan.example.id
  description = "The ID of the Azure App Service Plan"
}

output "app_service_plan_name" {
  value       = azurerm_app_service_plan.example.name
  description = "The name of the Azure App Service Plan"
}

output "app_service_plan_tier" {
  value       = azurerm_app_service_plan.example.sku.0.tier
  description = "The pricing tier of the Azure App Service Plan"
}

output "app_service_plan_size" {
  value       = azurerm_app_service_plan.example.sku.0.size
  description = "The size of the Azure App Service Plan"
}

output "app_service_plan_kind" {
  value       = azurerm_app_service_plan.example.kind
  description = "The kind of the Azure App Service Plan"
}

output "app_service_plan_maximum_number_of_workers" {
  value       = azurerm_app_service_plan.example.maximum_number_of_workers
  description = "The maximum number of workers for the Azure App Service Plan"
}
