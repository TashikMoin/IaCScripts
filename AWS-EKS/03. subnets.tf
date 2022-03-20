# aws recommends to create subnets in multiple availbility zones inside a vpc.
# therefore, 2 subnets including 1 private and 1 public in az 1A of a VPC
# and remaining 2 subnets including 1 private and 1 public in az 1B of a VPC

resource "aws_subnet" "first-private-subnet" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    "Name" = "private-us-east-1a"

    "kubernetes.io/role/internal-elb" = "1"
    # this tag is important and MANDATORY to define because it will help kubernetes to discover those private subnets
    # in which it can do internal loadbalancing of services.

    "kubernetes.io/cluster/${var.cluster-name}" = "shared"
    # Key: kubernetes.io/cluster/yourEKSClusterName
    # Value: shared
    # MANDATORY
  }
}

resource "aws_subnet" "second-private-subnet" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1b"

  tags = {
    "Name" = "private-us-east-1b"

    "kubernetes.io/role/internal-elb" = "1"
    # this tag is important and MANDATORY to define because it will help kubernetes to discover those private subnets
    # in which it can do internal loadbalancing of services.

    "kubernetes.io/cluster/${var.cluster-name}" = "shared"
    # Key: kubernetes.io/cluster/yourEKSClusterName
    # Value: shared
    # MANDATORY
  }
}

resource "aws_subnet" "first-public-subnet" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "us-east-1a"

  map_public_ip_on_launch = true
  # it allows the instances to get public ip addresses when the instances are deployed in a public subnet.

  tags = {
    "Name" = "public-us-east-1a"

    "kubernetes.io/role/elb" = "1"
    # this tag is required by the EKS service and is MANDATORY to define because when we expose
    # a loadbalancer service, this tag will help the eks service to determine/discover available 
    # public subnets on which it can balance the load.

    "kubernetes.io/cluster/${var.cluster-name}" = "shared"
    # Key: kubernetes.io/cluster/yourEKSClusterName
    # Value: shared
    # MANDATORY
    # this tag will allow eks to discover and share services like public load balancer among 
    # available public subnets.
  }
}

resource "aws_subnet" "second-public-subnet" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.4.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true
  # it allows the instances to get public ip addresses when the instances are deployed in a public subnet.

  tags = {
    "Name" = "public-us-east-1b"

    "kubernetes.io/role/elb" = "1"
    # this tag is required by the EKS service and is MANDATORY to define because when we expose
    # a loadbalancer service, this tag will help the eks service to determine/discover available 
    # public subnets on which it can balance the load.

    "kubernetes.io/cluster/${var.cluster-name}" = "shared"
    # Key: kubernetes.io/cluster/yourEKSClusterName
    # Value: shared
    # MANDATORY
    # this tag will allow eks to discover and share services among available public subnets.
  }
}


# reference: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet 
