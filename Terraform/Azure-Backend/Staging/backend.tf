terraform {
  backend "azurerm" {
    storage_account_name = "statebackend"
    container_name       = "terraform-backend-state-container"
    resource_group_name  = "backend_state_rg"
    key                  = "/terraform/state"
  }
}
