resource "aws_eip" "eip-first-public-subnet" {
  depends_on = [aws_internet_gateway.igw]
  # explicit dependency optional, but good practice because if we do not define this explicit
  # dependency, terraform may create the internet gateway and eip in parallel however first
  # the internet gateway should be created and then the eip and then there association using a
  # NAT.

  tags = {
    Name = "eip-first-public-subnet"
  }
}

resource "aws_eip" "eip-second-public-subnet" {
  depends_on = [aws_internet_gateway.igw]
  # explicit dependency optional, but good practice because if we do not define this explicit
  # dependency, terraform may create the internet gateway and eip in parallel however first
  # the internet gateway should be created and then the eip and then there association using a
  # NAT.

  tags = {
    Name = "eip-second-public-subnet"
  }
}


