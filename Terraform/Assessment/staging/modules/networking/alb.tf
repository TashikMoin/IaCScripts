resource "aws_lb" "monese_alb" {
  name               = "${var.AWS_ALB_NAME}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.monese_security_group.id]
  idle_timeout       = 120
  subnet_mapping {
    subnet_id            = aws_subnet.public_subnet_a.id
  }
  subnet_mapping {
    subnet_id            = aws_subnet.public_subnet_b.id
  }
  enable_deletion_protection = false
  # prevent terraform to delete the alb.
}

