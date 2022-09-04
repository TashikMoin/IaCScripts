resource "aws_vpc_endpoint" "s3" {
  vpc_id       = aws_vpc.vpc.id
  service_name = "com.amazonaws.${var.REGION}.s3"
}


# route table for the endpoint
resource "aws_route_table" "route_table_private_subnet_a" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "Endpoint Route"
  }
}

resource "aws_route_table_association" "route_association_private_subnet_a" {
  subnet_id      = aws_subnet.private_subnet_a.id
  route_table_id = aws_route_table.route_table_private_subnet_a.id
}

resource "aws_vpc_endpoint_route_table_association" "endpoint_route_association" {
  route_table_id  = aws_route_table.route_table_private_subnet_a.id
  vpc_endpoint_id = aws_vpc_endpoint.s3.id
}

resource "aws_vpc_endpoint_policy" "endpoint_policy" {
  vpc_endpoint_id = aws_vpc_endpoint.s3.id
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "AllowAll",
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : "*"
        },
        "Action" : [
          "s3:*"
        ],
        "Resource" : "*"
      }
    ]
  })
}