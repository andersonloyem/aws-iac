
module "table_insuree" {
  source       = "../dynamobd"
  name_table   = "insuree"
  env          = var.env
  hash_key     = "insuree_id"
  range_key    = "email"
  billing_mode = "PROVISIONED"
  attribute_list = [
    { name = "insuree_id", type = "S" },
    { name = "email", type = "S" }
  ]
  index_list = [
    {name = "emailIndex", hash_key = "email", non_key=["insuree_id"]}
  ]
  tags    = var.aws_common_tag
}

module "table_premium" {
  source       = "../dynamobd"
  name_table   = "premium"
  env          = var.env
  hash_key     = "premium_id"
  range_key    = "email"
  billing_mode = "PROVISIONED"
  attribute_list = [
    { name = "premium_id", type = "S" },
    { name = "email", type = "S" }
  ]
  index_list = [
    {name = "emailIndex", hash_key = "email", non_key=["premium_id"]}
  ]
  tags    = var.aws_common_tag
}