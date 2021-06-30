terraform {
  backend "s3" {
    bucket                  = "terraform-aws-assurly"
    key                     = "storage.dev.tfstate"
    shared_credentials_file = "$HOME/.aws/remote_terraform_cred"
    region                  = "eu-west-3"
  }
}
