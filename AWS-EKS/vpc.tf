data "aws_availability_zones" "available" {}
# for getting all the availability zones.

locals {
  cluster_name = "K8-EKS-Cluster"
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name                 = "K8-EKS-VPC"
  cidr                 = "10.0.0.0/16"
  azs                  = data.aws_availability_zones.available.names
  private_subnets      = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets       = ["10.0.3.0/24", "10.0.4.0/24"]
  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true

  tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
  }

  public_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                      = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"             = "1"
  }
}
# using a predefined VPC module of terraform to create a VPC on AWS 
# Inside this VPC, we will create our K8 cluster of AWS EKS service.
# multiple resource container or module for AWS VPC.
