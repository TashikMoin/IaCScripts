locals {
  default_tags = {
    scope = "Terraform"
  }
  all_tags = merge(local.default_tags, var.state_tags)
}

resource "azurerm_resource_group" "state_backend_resource_group" {
  name     = var.state_backend_resource_group_name
  location = var.state_location
  tags     = local.all_tags
}

# creating a separate rg for state backend and applying lock at that rg so that the backend_state_rg cannot be deleted.
resource "azurerm_management_lock" "backend_state_rg" {
  name       = "${var.state_backend_resource_group_name}-lock"
  count      = var.state_create_lock ? 1 : 0
  scope      = azurerm_resource_group.state_backend_resource_group.id 
  lock_level = "CanNotDelete"
}

resource "azurerm_storage_account" "sa_tf_state" {
  name                     = var.state_storage_account_name
  resource_group_name      = azurerm_resource_group.state_backend_resource_group.name
  location                 = var.state_location
  account_tier             = var.state_storage_account_tier
  account_replication_type = var.state_storage_account_replication_type
  access_tier              = var.state_storage_account_access_tier
  tags                     = local.all_tags
}

resource "azurerm_storage_container" "sc_tf_state" {
  name                  = var.state_storage_container_name
  storage_account_name  = azurerm_storage_account.sa_tf_state.name
  container_access_type = var.state_storage_container_access_type
}