# General
variable "REGION" {
  default = "eu-west-1"
  type    = string
}




# Credentials
variable "ACCESS_KEY" {
  type    = string
}

variable "SECRET_KEY" {
  type    = string
}




# State backend
variable "STATE_BUCKET" {
  default = "state-bucket-monese"
  type    = string
}

variable "DYNAMO_TABLE" {
  default = "dynamodb-state-table"
  type    = string
}




# VPC
variable "VPC_NAME" {
  default = "monese-vpc"
  type    = string
}

variable "CIDR_BLOCK" {
  default = "10.0.0.0/16"
  type    = string
}




# Subnets
variable "PRIVATE_SUBNET_A_CIDR_BLOCK" {
  default = "10.0.1.0/24"
  type    = string
}

variable "PUBLIC_SUBNET_A_CIDR_BLOCK" {
  default = "10.0.2.0/24"
  type    = string
}

variable "ROUTE_TABLE_PUBLIC_SUBNET_A" {
  default = "route-table-public-subnet-a"
  type    = string
}

variable "PUBLIC_SUBNET_B_CIDR_BLOCK" {
  default = "10.0.3.0/24"
  type    = string
}

variable "ROUTE_TABLE_PUBLIC_SUBNET_B" {
  default = "route-table-public-subnet-b"
  type    = string
}




# Gateway
variable "GATEWAY" {
  default = "monese-vpc-gw"
  type    = string
}




# Data bucket
variable "SOURCE_CODE_BUCKET" {
  default = "source-code-bucket-monese"
  type    = string
}

variable "DATA_BUCKET" {
  default = "data-bucket-monese"
  type    = string
}


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

variable "LAMBDA_TARGET_GROUP_NAME" {
  default = "monese-lambda-tg"
  type    = string
}


# LB
variable "AWS_ALB_NAME" {
  default = "monese-alb"
}



