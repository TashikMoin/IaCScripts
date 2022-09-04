# Attaching the policy to our lambda role.
resource "aws_iam_role_policy_attachment" "data_lambda_policy" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  # Assigning permissions to store logs into Cloudwatch using a role with assume policy.
}


resource "aws_cloudwatch_log_group" "fetch_data" {
  name = "/aws/lambda/${aws_lambda_function.fetch_data.function_name}"
  retention_in_days = 0
  # 0 retention days means the events in the log group will never expire. We can also set other values.
  # We can also use kms keys to encrypt the log data.
}
# CW log group to group logs streams
# Log streams that share the same retention, monitoring, and access control settings can be grouped into one cw log group.
# A stream is a sequence of events coming from the resource being monitored.