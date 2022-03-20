provider "aws" {
  region = "us-east-1"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
    mycloud = {
      source  = "hashicorp/kubernetes"
      version = "~> 1.13"
    }
  }
}

provider "kubernetes" {
  host = aws_eks_cluster.K8-cluster.endpoint
}
