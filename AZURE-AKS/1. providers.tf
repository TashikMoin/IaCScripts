provider "azurerm" {
  features {}
  // azure service principal
  # subscription_id = var.ARM_SUBSCRIPTION_ID
  # client_id       = var.ARM_CLIENT_ID
  # client_secret   = var.ARM_CLIENT_SECRET
  # tenant_id       = var.ARM_TENANT_ID
}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>2.0"
    }
  }
  // for backend cloud storage for infrastructure state files.
  # backend "azurerm" {
    
  #   resource_group_name  = "<storage_account_resource_group>"
  #   storage_account_name = "<storage_account_name>"
  #   container_name       = <storage container name>
  #   key                  = "prod.terraform.tfstate" <tf statefile name>
  #   subscription_id      = "00000000-0000-0000-0000-000000000000"
  #   tenant_id            = "00000000-0000-0000-0000-000000000000"
  #   client_id            = "00000000-0000-0000-0000-000000000000"
  #   client_secret        = "00000000-0000-0000-0000-000000000000"

  // when managed service identity (MSI) is used for authentication
  #   use_msi              = true

  // when azure ad is used for authentication
  #   use_azuread_auth     = true

  // when authentication with key associated to storage accounnt
  #   access_key = ""

  // when authenticating using sas token
  #   sas_token = "abcdefghijklmnopqrstuvwxyz0123456789..."

  // for other authentication ways visit the following link,
  #  https://www.terraform.io/language/settings/backends/azurerm

  # }

  # An alternative for backend block, create a backend.conf file and define the following,
  # subscription_id      = ""
  # tenant_id            = ""
  # client_id            = ""
  # client_secret        = ""
  # resource_group_name  = ""
  # storage_account_name = ""
  # container_name       = ""
  # key                  = ""
  # after defining the block, run terraform init command with following flag, 
  # --backend-config=backend.conf
}