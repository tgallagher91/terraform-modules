variable "static_site_name" {
  description = "The name of the Azure Static Web App"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group where the Azure Static Web App will be created"
  type        = string
}

variable "location" {
  description = "The location where the Azure Static Web App should be created"
  type        = string
}
