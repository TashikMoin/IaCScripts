# Lambda
variable "LAMBDA_FUNCTION_NAME" {
  default = "fetch_data"
  type    = string
}

variable "LAMBDA_RUNTIME" {
  default = "python3.9"
  type    = string
}

variable "LAMBDA_HANDLER" {
  default = "function.handler"
  type    = string
}

variable "LAMBDA_ROLE_NAME" {
  default = "fetch_data_lambda_role"
  type    = string
}

variable "SOURCE_CODE_BUCKET_ID" {
    type  = any
}

variable "PRIVATE_SUBNET_A_ID" {
    type  = any
}

variable "SECURITY_GROUP_ID" {
    type  = any
}

variable "LAMBDA_TARGET_GROUP_NAME" {
  default = "monese-lambda-tg"
  type    = string
}

variable "ALB_ARN" {
  type   = any
}

variable "LAMBDA_SSS_POLICY" {
  default = "lambda_sss_policy"
}



# VPC
variable "VPC_ID" {
  type   = any
}


# Environments
variable "PAGESIZE" {
  default = 100
}

variable "REGION" {
  default = "eu-west-1"
  type    = string
}

variable "BUCKET" {
  default = "data-bucket-monese"
  type    = string
}