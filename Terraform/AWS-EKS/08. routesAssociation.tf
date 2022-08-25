resource "aws_route_table_association" "route-association-first-private-subnet" {
  subnet_id      = aws_subnet.first-private-subnet.id
  route_table_id = aws_route_table.route-table-first-private-subnet.id
}

resource "aws_route_table_association" "route-association-second-private-subnet" {
  subnet_id      = aws_subnet.second-private-subnet.id
  route_table_id = aws_route_table.route-table-second-private-subnet.id
}

resource "aws_route_table_association" "route-association-first-public-subnet" {
  subnet_id      = aws_subnet.first-public-subnet.id
  route_table_id = aws_route_table.route-table-public-subnets.id
}

resource "aws_route_table_association" "route-association-second-public-subnet" {
  subnet_id      = aws_subnet.second-public-subnet.id
  route_table_id = aws_route_table.route-table-public-subnets.id
}
