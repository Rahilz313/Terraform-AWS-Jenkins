# Define IAM role for Lambda
resource "aws_iam_role" "lambda_role" {
  name = "lambda_s3_full_access_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

# Attach a policy to the IAM role for full S3 access
resource "aws_iam_role_policy_attachment" "lambda_s3_full_access_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess" # Full access to S3
  role       = aws_iam_role.lambda_role.name
}

# Attach the Lambda basic execution policy directly to the IAM role
resource "aws_iam_role_policy_attachment" "lambda_basic_execution_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole" # Basic Lambda execution permissions
  role       = aws_iam_role.lambda_role.name
}

# Attach a policy to the IAM role for full DynamoDB access
resource "aws_iam_role_policy_attachment" "lambda_dynamodb_full_access_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess" # Full access to DynamoDB
  role       = aws_iam_role.lambda_role.name
}
