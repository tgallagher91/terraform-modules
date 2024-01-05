variable "web_app_name" {
  description = "The name of the Azure Web App"
  type        = string
}

variable "app_service_location" {
  description = "The location of the Azure App Service"
  type        = string
}

variable "app_service_rsg" {
  description = "The resource group name of the Azure App Service"
  type        = string
}

variable "app_spid" {
  description = "The ID of the Azure App Service Plan"
  type        = string
}
