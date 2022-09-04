resource "aws_s3_bucket" "source_code_bucket" {
  bucket        = var.SOURCE_CODE_BUCKET
  force_destroy = true
}

resource "aws_s3_bucket_public_access_block" "source_code_bucket" {
  bucket = aws_s3_bucket.source_code_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}