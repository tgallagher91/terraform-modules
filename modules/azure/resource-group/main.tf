resource "azurerm_resource_group" "example" {
  name     = var.rsg_name
  location = var.rsg_location
}