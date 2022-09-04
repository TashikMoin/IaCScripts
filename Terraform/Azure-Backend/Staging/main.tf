module "storage" {
  source = "./modules/storage"

  # State backend parameters
  state_backend_resource_group_name      = var.state_backend_resource_group_name
  state_storage_account_name             = var.state_storage_account_name
  state_storage_account_tier             = var.state_storage_account_tier
  state_storage_account_replication_type = var.state_storage_account_replication_type
  state_storage_account_access_tier      = var.state_storage_account_access_tier
  state_storage_container_name           = var.state_storage_container_name
  state_storage_container_access_type    = var.state_storage_container_access_type
  state_create_lock                      = var.state_create_lock
  state_location                         = var.state_location
  state_tags                             = var.state_tags

  # Others networking sub-modules parameters
}


module "networking" {
  source = "./modules/networking"

  ajman_resource_group = var.ajman_resource_group
  ajman_region         = var.ajman_region
}

