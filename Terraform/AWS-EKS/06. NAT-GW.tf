# 2 NAT gateways for 2 public subnets. The 2 Elastic IPs that were created in the previous step
# are used here for association with each of these two subnets. 

resource "aws_nat_gateway" "nat-first-public-subnet" {
  allocation_id = aws_eip.eip-first-public-subnet.id
  subnet_id     = aws_subnet.first-public-subnet.id

  tags = {
    Name = "nat-first-public-subnet"
  }

  depends_on = [aws_internet_gateway.igw]
  # explicit dependency optional
}




resource "aws_nat_gateway" "nat-second-public-subnet" {
  allocation_id = aws_eip.eip-second-public-subnet.id
  subnet_id     = aws_subnet.second-public-subnet.id

  tags = {
    Name = "nat-second-public-subnet"
  }

  depends_on = [aws_internet_gateway.igw]
  # explicit dependency optional
}
