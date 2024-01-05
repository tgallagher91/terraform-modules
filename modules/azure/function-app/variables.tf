variable "function_app_name" {
  description = "The name of the Azure Function App"
  type        = string
}

variable "function_app_location" {
  description = "The location of the Azure Function App"
  type        = string
}

variable "function_app_rsg" {
  description = "The resource group name for the Azure Function App"
  type        = string
}

variable "function_app_spid" {
  description = "The ID of the Azure App Service Plan associated with the Azure Function App"
  type        = string
}

variable "storage_account_name" {
  description = "The name of the storage account associated with the Azure Function App"
  type        = string
}

variable "storage_account_access_key" {
  description = "The access key for the storage account"
  type        = string
}
