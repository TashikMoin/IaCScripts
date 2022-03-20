provider "aws" {
  region = "us-east-1"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "kubernetes" {
  host                   = aws_eks_cluster.K8-cluster.endpoint
  cluster_ca_certificate = base64decode(aws_eks_cluster.K8-cluster.certificate_authority[0].data)
}
