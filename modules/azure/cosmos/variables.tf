variable "assigned_identity_rsg" {
  description = "The resource group name for the user assigned identity"
  type        = string
}

variable "assigned_identity_name" {
  description = "The name of the user assigned identity"
  type        = string
}

variable "cosmos_name" {
  description = "The name of the Cosmos DB Account"
  type        = string
}

variable "cosmos_rsg_name" {
  description = "The resource group name for the Cosmos DB Account"
  type        = string
}

variable "cosmos_offer_type" {
  description = "The offer type for the Cosmos DB Account"
  type        = string
}

variable "cosmos_db_kind" {
  description = "The kind of Cosmos DB Account"
  type        = string
}
