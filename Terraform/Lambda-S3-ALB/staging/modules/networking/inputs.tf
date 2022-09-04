# VPC
variable "VPC_NAME" {
  default = "monese-vpc"
  type    = string
}

variable "CIDR_BLOCK" {
  default = "10.0.0.0/16"
  type    = string
}

variable "REGION" {
  default = "eu-west-1"
  type    = string
}



# Routing
variable "GATEWAY" {
  default = "monese-vpc-gw"
  type    = string
}

variable "PRIVATE_SUBNET_A_CIDR_BLOCK" {
  default = "10.0.1.0/24"
  type    = string
}

variable "PUBLIC_SUBNET_A_CIDR_BLOCK" {
  default = "10.0.2.0/24"
  type    = string
}

variable "ROUTE_TABLE_PUBLIC_SUBNET_A" {
  default = "route-table-public-subnet-a"
  type    = string
}

variable "PUBLIC_SUBNET_B_CIDR_BLOCK" {
  default = "10.0.3.0/24"
  type    = string
}

variable "ROUTE_TABLE_PUBLIC_SUBNET_B" {
  default = "route-table-public-subnet-b"
  type    = string
}

variable "AWS_ALB_NAME" {
  default = "monese-alb"
}