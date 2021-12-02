resource "aws_dynamodb_table" "basic-dynamodb-table" {
  name           = local.app_name
  billing_mode   = "PROVISIONED"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "Messages"
  range_key      = "MSGTitle"

  attribute {
    name = "Messages"
    type = "S"
  }

  attribute {
    name = "MSGTitle"
    type = "S"
  }

  ttl {
    attribute_name = "TimeToExist"
    enabled        = true
  }

  tags = {
    Name        = "EKSDemo"
    Environment = "production"
  }
}