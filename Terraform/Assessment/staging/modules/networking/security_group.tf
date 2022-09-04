# Create SSH security group for public subnet
resource "aws_security_group" "monese_security_group" {
  name        = ""
  description = "Security Group"
  vpc_id      = aws_vpc.vpc.id
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow incoming HTTP connections"  
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow incoming HTTPS connections"  
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }
  /* By default, when Terraform must change a resource argument that cannot be updated in-place due to remote API limitations, Terraform will instead 
  destroy the existing object and then create a new replacement object with the new configured arguments. The create_before_destroy meta-argument changes 
  this behavior so that "the new replacement object is created first", and the prior object is destroyed after the replacement is created. */
}