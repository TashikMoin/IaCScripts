resource "aws_vpc" "vpc" {
  cidr_block                       = "${var.CIDR_BLOCK}"
  instance_tenancy                 = "default"
  enable_dns_support               = true
  enable_dns_hostnames             = true
  enable_classiclink               = false
  enable_classiclink_dns_support   = false
  assign_generated_ipv6_cidr_block = false

  tags = {
    Name = "${var.VPC_NAME}"
  }
}