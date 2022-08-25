locals {
  # importing envs
  env_vars = read_terragrunt_config("env.hcl")

  # Further extract the imported local variables to shorten long names
  ARM_SUBSCRIPTION_ID    = local.env_vars.locals.ARM_SUBSCRIPTION_ID
  ARM_CLIENT_ID          = local.env_vars.locals.ARM_CLIENT_ID
  ARM_CLIENT_SECRET      = local.env_vars.locals.ARM_CLIENT_SECRET
  ARM_TENANT_ID          = local.env_vars.locals.ARM_TENANT_ID
  RESOURCE_GROUP_NAME    = local.env_vars.locals.RESOURCE_GROUP_NAME
  STORAGE_ACCOUNT_NAME   = local.env_vars.locals.STORAGE_ACCOUNT_NAME
  CONTAINER_NAME         = local.env_vars.locals.CONTAINER_NAME
}

inputs = merge(
  local.env_vars.locals
)


# Generate Azure providers
generate "providers" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
    terraform {
      required_providers {
        azurerm = {
          source = "hashicorp/azurerm"
          version = "2.95.0"
        }
      }
    }

    provider "azurerm" {
        features {}
        subscription_id    = "${local.ARM_SUBSCRIPTION_ID}"
        client_id          = "${local.ARM_CLIENT_ID}"
        client_secret      = "${local.ARM_CLIENT_SECRET}"
        tenant_id          = "${local.ARM_TENANT_ID}"
    }
EOF
}

remote_state {
    backend = "azurerm"
    config = {
        subscription_id        = "${local.ARM_SUBSCRIPTION_ID}"
        key                    = "${path_relative_to_include()}/terraform.tfstate"
        resource_group_name    = "${local.RESOURCE_GROUP_NAME}"
        storage_account_name   = "${local.STORAGE_ACCOUNT_NAME}"
        container_name         = "${local.CONTAINER_NAME}"
    }
    generate = {
        path      = "backend.tf"
        if_exists = "overwrite_terragrunt"
    }
}
