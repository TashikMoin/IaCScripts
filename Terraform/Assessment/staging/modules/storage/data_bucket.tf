resource "aws_s3_bucket" "data_bucket" {
  bucket        = var.DATA_BUCKET
  force_destroy = true
}

resource "aws_s3_bucket_public_access_block" "data_bucket" {
  bucket = aws_s3_bucket.data_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_object" "data_bucket_objects" {
  for_each = fileset("${path.module}/documents/", "**")
  bucket = aws_s3_bucket.data_bucket.id
  key = each.value
  source = "${path.module}/documents/${each.value}"
  etag = filemd5("${path.module}/documents/${each.value}")
}
