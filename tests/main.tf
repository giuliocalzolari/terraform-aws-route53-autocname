provider "aws" {
  region = "eu-central-1"
}

terraform {
  required_version = ">= 0.12.3"
}


module "this" {
  source  = "giuliocalzolari/route53-autocname/aws"
  version = "1.0.2"
}

