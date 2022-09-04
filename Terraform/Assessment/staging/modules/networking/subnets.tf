resource "aws_subnet" "private_subnet_a" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "${var.PRIVATE_SUBNET_A_CIDR_BLOCK}"
  availability_zone = "${var.REGION}a"

  tags = {
    "Name" = "monese-private-subnet-${var.REGION}a"
  }
}


resource "aws_subnet" "public_subnet_a" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "${var.PUBLIC_SUBNET_A_CIDR_BLOCK}"
  availability_zone = "${var.REGION}a"

  map_public_ip_on_launch = true
  # it allows the instances to get public ip addresses when the instances are deployed in a public subnet.

  tags = {
    "Name" = "monese-public-subnet-${var.REGION}a"
    "Type" = "public"
  }
}


resource "aws_subnet" "public_subnet_b" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "${var.PUBLIC_SUBNET_B_CIDR_BLOCK}"
  availability_zone = "${var.REGION}b"

  map_public_ip_on_launch = true
  # it allows the instances to get public ip addresses when the instances are deployed in a public subnet.

  tags = {
    "Name" = "monese-public-subnet-${var.REGION}b"
    "Type" = "public"
  }
}
