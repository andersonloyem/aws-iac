module "all_table" {
  source         = "../../modules/database"
  aws_common_tag = var.aws_common_tag
  env            = var.env
}