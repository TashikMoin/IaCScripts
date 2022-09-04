resource "aws_lambda_function" "fetch_data" {
  function_name = "${var.LAMBDA_FUNCTION_NAME}"

  s3_bucket = var.SOURCE_CODE_BUCKET_ID 
  # Bucket where the lambda function is stored as zip.

  s3_key    = aws_s3_object.lambda_source_code.key 
  # Key of the object so that we can find where the lambda is stored.

  runtime = "${var.LAMBDA_RUNTIME}"

  handler = "${var.LAMBDA_HANDLER}"
  # handler function name.

  source_code_hash = data.archive_file.lambda_source_code.output_base64sha256 
  # To redeploy the lambda function if any changes are done in the source code.

  role = aws_iam_role.lambda_role.arn
  # assigning the role that we created to the lambda function so that it can access other resources.

  timeout = 120 # 2 minutes
  memory_size = 4096 # > memory < response time

  vpc_config {
    # Every subnet should be able to reach an EFS mount target in the same Availability Zone. Cross-AZ mounts are not permitted.
    subnet_ids         = [var.PRIVATE_SUBNET_A_ID]
    security_group_ids = [var.SECURITY_GROUP_ID]
  }

  environment {
    variables = {
      bucket = "${var.BUCKET}"
      region = "${var.REGION}"
      pagesize = "${var.PAGESIZE}"
    }
  }
}