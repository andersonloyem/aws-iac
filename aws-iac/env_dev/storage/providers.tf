provider "aws" {
  profile = "default"
  #version = "2.10"
  shared_credentials_file = "$HOME/.aws/dev_cred"
  region                  = var.aws_region
}
