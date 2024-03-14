

resource "aws_cloudwatch_event_rule" "s3_event_rule" {
  name        = "s3_event_rule"
  description = "EventBridge rule for S3 bucket events"
  event_pattern = <<PATTERN
{
  "detail-type": ["Object Created", "Object Deleted"],
  "source": ["aws.s3"],
  "detail": {
    "bucket": {
      "name": ["aws_s3_bucket.bucket.bucket"]
    }
  }
}
PATTERN
}

resource "aws_cloudwatch_event_target" "lambda_target" {
  target_id = "lambda-terraform-jenkins"
  rule      = aws_cloudwatch_event_rule.s3_event_rule.name
  arn       = aws_lambda_function.example_lambda.arn  
}
