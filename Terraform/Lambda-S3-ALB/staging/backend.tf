# Important Note
# Comment below code and execute terraform init, plan, apply with your local state files so that our remote backend resources can be provisioned. Once that is done, uncomment below code and re-run tf commands.

terraform {
 backend "s3" {
   bucket         = "state-bucket-monese"
   key            = "state/terraform.tfstate" # remote path
   region         = "eu-west-1"
   encrypt        = true
   dynamodb_table = "dynamodb-state-table"
 }
}




