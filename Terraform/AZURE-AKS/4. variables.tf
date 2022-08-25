variable "resource_group_name" {
  type        = string
  description = "RG name in Azure"
}
variable "location" {
  type        = string
  description = "Resources location at Microsoft Azure"
}
variable "cluster_name" {
  type        = string
  description = "AKS cluster name at Microsoft Azure"
}
variable "kubernetes_version" {
  type        = string
  description = "Kubernetes version on AKS cluster at Microsoft Azure"
}
variable "system_node_count" {
  type        = number
  description = "Number of AKS worker nodes on AKS cluster at Microsoft Azure"
}

variable "vm_size" {
  type        = string
  description = "Virtual machine size/family/flavor"
}
