variable "env" {
  description = "env: dev or prod"
  default     = "dev"
}

variable "aws_region" {
  type        = string
  default     = "eu-west-3"
  description = "value"
}

variable "aws_common_tag" {
  type        = map(any)
  description = "aws tag commun"
  default = {
    Name = "assurly-back"
    //Owner        = var.Owner
    Organization = "assurly"
    App          = "assurly-back"
    Entity       = "table"
    env          = "dev"
  }
}

variable "Owner" {
  description = "env: dev or prod"
  default     = "dev"
}

