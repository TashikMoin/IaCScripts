resource "aws_iam_role" "lambda_role" {
  name = "${var.LAMBDA_ROLE_NAME}"
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

# s3 access policy
# Giving permissions to all s3 actions
# Giving permissions to all s3 resources and not a specific resource.
resource "aws_iam_policy" "lambda_sss_policy" {
  name = "${var.LAMBDA_SSS_POLICY}"
  description = "Policy for s3 access"
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "logs:*"
            ],
            "Resource": "arn:aws:logs:*:*:*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "s3:*"
            ],
            "Resource": "arn:aws:s3:::*"
        }
    ]
  })
}



# s3 policy-role attachment
resource "aws_iam_role_policy_attachment" "lambda_sss_attachment" {
  role       = "${aws_iam_role.lambda_role.name}"
  policy_arn = "${aws_iam_policy.lambda_sss_policy.arn}"
}


# This policy is allowing lambda to create network interfaces so that it can become part of the VPC.
resource "aws_iam_role_policy_attachment" "AWSLambdaVPCAccessExecutionRole" {
    role       = aws_iam_role.lambda_role.name
    policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
}


# Defining ALB target group, tg-attachment here to avoid the "INTERDEPENDENCY" of the modules (Networking module <---> Application module).
resource "aws_lb_target_group" "lambda_tg" {
  name        = "${var.LAMBDA_TARGET_GROUP_NAME}"
  target_type = "lambda"
  vpc_id      = var.VPC_ID
}

resource "aws_lb_target_group_attachment" "lambda_tg_attachment" {
  target_group_arn = aws_lb_target_group.lambda_tg.arn
  target_id        = aws_lambda_function.fetch_data.arn
  depends_on = [ aws_lambda_permission.alb_lambda_permissions ]
}


resource "aws_lb_listener" "monese_alb_listener" {
  load_balancer_arn = var.ALB_ARN
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lambda_tg.arn
  }

}


resource "aws_lb_listener_rule" "records" {
  listener_arn = aws_lb_listener.monese_alb_listener.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lambda_tg.arn
  }

  condition {
    http_request_method {
      values = ["GET"]
    }
  }

  condition {
    path_pattern {
      values = ["/lambda/get-objects"] 
    }
  }
}


resource "aws_lambda_permission" "alb_lambda_permissions" {
  statement_id  = "AllowExecutionFromlb"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.fetch_data.function_name
  principal     = "elasticloadbalancing.amazonaws.com"
  source_arn    = aws_lb_target_group.lambda_tg.arn
}