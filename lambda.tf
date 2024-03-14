#Create Lambda function
data "archive_file" "lambda" {
  type        = "zip"
  source_file = "code.py"
  output_path = "Outputs/lambda.zip"
}
resource "aws_lambda_function" "example_lambda" {
  function_name = "lambda-terraform-jenkins"
  handler       = "code.lambda_handler"
  runtime       = "python3.8"
  filename      = "Outputs/lambda.zip" # Change to your Lambda function code package
  role          = aws_iam_role.lambda_role.arn
}

# Attach a policy to allow CloudWatch Events to invoke the Lambda function
resource "aws_lambda_permission" "allow_cloudwatch_events" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.example_lambda.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.s3_event_rule.arn
}
