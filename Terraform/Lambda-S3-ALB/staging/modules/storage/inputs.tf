# State backend
variable "STATE_BUCKET" {
  default = "state-bucket-monese"
  type    = string
}

variable "DYNAMO_TABLE" {
  default = "dynamodb-state-table"
  type    = string
}

# Buckets
variable "SOURCE_CODE_BUCKET" {
  default = "source-code-bucket-monese"
  type    = string
}

variable "DATA_BUCKET" {
  default = "data-bucket-monese"
  type    = string
}
