# Output for Azure Resource Group Name
output "resource_group_name" {
  value = azurerm_resource_group.example.name
  description = "The name of the Resource Group"
}

# Output for Azure Resource Group Location
output "resource_group_location" {
  value = azurerm_resource_group.example.location
  description = "The location of the Resource Group"
}
