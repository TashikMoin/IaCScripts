# VPC
output "VPC_ID" {
  value = aws_vpc.vpc.id
}

# Subnets
output "PRIVATE_SUBNET_A_ID" {
  value = aws_subnet.private_subnet_a.id
}

output "PUBLIC_SUBNET_A_ID" {
  value = aws_subnet.public_subnet_a.id
}

# Security Group
output "SECURITY_GROUP_ID" {
  value = aws_security_group.monese_security_group.id
}


# ALB
output "ALB_ARN" {
  value = aws_lb.monese_alb.arn
}