# TF state backend vars
variable "state_backend_resource_group_name" {
  type        = string
  default     = "backend_state_rg"
  description = "Name of the Azure Resource Group for state backend"
}

variable "state_location" {
  type        = string
  default     = "uaenorth"
  description = "Azure Region where services should be created"
}

variable "state_tags" {
  type        = map
  default     = {}
  description = "A map of Azure tags, assoicated with all created resources"
}

variable "state_create_lock" {
  type        = bool
  default     = true
  description = "Should an Azure Management Lock being created?"
}

variable "state_storage_account_name" {
  type        = string
  default     = "statebackend"
  description = "Name of the Azure Storage Account"
}

variable "state_storage_container_name" {
  type        = string
  default     = "terraform-backend-state-container"
  description = "Name of the Blob container (defaults to terraform_state)"
}

variable "state_storage_account_tier" {
  type        = string
  default     = "Standard"
  description = "Azure Storage Account Tier (defaults to Standard)"
}

variable "state_storage_account_replication_type" {
  type        = string
  default     = "LRS"
  description = "Azure Storage Account Replication Type (defaults to LRS)"
}

variable "state_storage_account_access_tier" {
  type        = string
  default     = "Hot"
  description = "Azure Storage Account Access Tier (defaults to Hot)"
}

variable "state_storage_container_access_type" {
  type        = string
  default     = "private"
  description = "Blob Container Access Type (defaults to private)"
}