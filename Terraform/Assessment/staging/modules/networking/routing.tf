resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.GATEWAY}"
  }
}


resource "aws_route_table" "route_table_public_subnet_a" {
  vpc_id = aws_vpc.vpc.id
  route { 
    cidr_block                 = "0.0.0.0/0"
    gateway_id                 = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "${var.ROUTE_TABLE_PUBLIC_SUBNET_A}"
  }
}


resource "aws_route_table_association" "route_association_public_subnet_a" {
  subnet_id      = aws_subnet.public_subnet_a.id
  route_table_id = aws_route_table.route_table_public_subnet_a.id
}


resource "aws_route_table" "route_table_public_subnet_b" {
  vpc_id = aws_vpc.vpc.id
  route { 
    cidr_block                 = "0.0.0.0/0"
    gateway_id                 = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "${var.ROUTE_TABLE_PUBLIC_SUBNET_B}"
  }
}


resource "aws_route_table_association" "route_association_public_subnet_b" {
  subnet_id      = aws_subnet.public_subnet_b.id
  route_table_id = aws_route_table.route_table_public_subnet_b.id
}

