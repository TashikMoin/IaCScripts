# Generated by Terragrunt. Sig: nIlQXj57tbuaRZEa
terraform {
  backend "azurerm" {
    container_name       = "terraform-state"
    key                  = "./terraform.tfstate"
    resource_group_name  = "terraform"
    storage_account_name = "terraformidenfo"
    subscription_id      = "56b988a3-eb59-4d5e-ad42-b22f73ee10f8"
  }
}
