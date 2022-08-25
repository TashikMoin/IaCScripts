// resource group for AKS
resource "azurerm_resource_group" "aks-rg" {
  name     = var.resource_group_name
  location = var.location
}


// aks cluster
resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.cluster_name
  kubernetes_version  = var.kubernetes_version
  location            = var.location
  resource_group_name = azurerm_resource_group.aks-rg.name
  dns_prefix          = var.cluster_name

  default_node_pool {
    name                = "system"
    node_count          = var.system_node_count
    vm_size             = var.vm_size 
    type                = "VirtualMachineScaleSets"
    availability_zones  = [1, 2, 3]
    enable_auto_scaling = false
  }

  # service_principal {
  #     client_id     = var.aks_service_principal_app_id
  #     client_secret = var.aks_service_principal_client_secret
  # }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    load_balancer_sku = "Standard"
    network_plugin    = "kubenet" 
  }
}
