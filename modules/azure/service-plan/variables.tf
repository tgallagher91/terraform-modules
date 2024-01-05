variable "app_service_name" {
  description = "The name of the Azure App Service Plan"
  type        = string
}

variable "location" {
  description = "The location where the Azure App Service Plan should be created"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group in which to create the Azure App Service Plan"
  type        = string
}

variable "tier_type" {
  description = "Specifies the tier of the App Service Plan"
  type        = string
}

variable "size" {
  description = "Specifies the size of the App Service Plan"
  type        = string
}
