resource "aws_dynamodb_table" "table" {
  name         = "MyTable"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "id"

  attribute {
    name = "id"
    type = "S"  # Change the type to String
  }
}

