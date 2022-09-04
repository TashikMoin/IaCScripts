# converting/packaging lambda source code data folder as zip/archive file.
data "archive_file" "lambda_source_code" {
  type = "zip"
  source_dir  = "${path.module}/lambda_source_code"
  output_path = "${path.module}/lambda_source_code.zip"
  # path.module returns path of current directory or the relative path.
  # do not forget to give this directory required permissions.
}


# next step is to upload the zip archieve to the s3 bucket so that lambda can receive the source code.
resource "aws_s3_object" "lambda_source_code" {
  bucket = var.SOURCE_CODE_BUCKET_ID
  key    = "lambda_source_code.zip" # name of the zip file as key of the bucket object.
  source = data.archive_file.lambda_source_code.output_path  # path to the zip file

  etag = filemd5(data.archive_file.lambda_source_code.output_path)
  # The etag let Terraform recognize when the object content has changed, regardless of the local filename or object path.
  # If we do not set the etag, then your newly added files or modified object content will not be detected by terraform and it will say 0 to add 0 to destroy when terraform plan is run.
  # To upload our latest changes, we set the etag with a md5 hash so that terraform can compare the hashes and reflect our changes.
  # The object size should be less than 16 MB otherwise it will not work.
}


