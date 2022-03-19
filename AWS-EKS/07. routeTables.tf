resource "aws_route_table" "route-table-first-private-subnet" {
  vpc_id = aws_vpc.vpc.id

  route = {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-first-public-subnet.id
  }

  tags = {
    Name = "route-table-first-private-subnet"
  }

}


resource "aws_route_table" "route-table-second-private-subnet" {
  vpc_id = aws_vpc.vpc.id

  route = {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-second-public-subnet.id
  }

  tags = {
    Name = "route-table-second-private-subnet"
  }

}




resource "aws_route_table" "route-table-public-subnets" {
  vpc_id = aws_vpc.vpc.id

  route = {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "route-table-public-subnets"
  }
}





