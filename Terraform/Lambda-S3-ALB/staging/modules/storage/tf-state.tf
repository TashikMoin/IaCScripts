# S3 for remote backend.
resource "aws_s3_bucket" "terraform-statebucketmonese" {
  bucket = var.STATE_BUCKET
}

resource "aws_s3_bucket_acl" "terraform-statebucketaclmonese" {
  bucket = aws_s3_bucket.terraform-statebucketmonese.id
  acl    = "private"
}


resource "aws_s3_bucket_versioning" "terraform-state-bucket-versioning-monese" {
    bucket = aws_s3_bucket.terraform-statebucketmonese.id
    versioning_configuration {
        status = "Enabled"
    }
    # To rollback to previous versions.
}



# Public access block
resource "aws_s3_bucket_public_access_block" "block" {
    bucket = aws_s3_bucket_versioning.terraform-state-bucket-versioning-monese.id
    block_public_acls       = true
    block_public_policy     = true
    ignore_public_acls      = true
    restrict_public_buckets = true
}



# DynamoDB table locking to prevent multiple users to perform write operation at the same time.
resource "aws_dynamodb_table" "terraform-state" {
    name           = var.DYNAMO_TABLE
    hash_key       = "LockID"
    attribute {
    name = "LockID"
    type = "S"
    }
    read_capacity  = 20
    write_capacity = 20
    # increasing the read and write capacity because the billing_mode is "PROVISIONED" and it requires at least 1CU.
}
