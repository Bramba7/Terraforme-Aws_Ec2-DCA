provider "aws" {
  region = var.region
}

terraform {
  backend "s3" {
    shared_credentials_file = "~/.aws/credentials"
    bucket                  = "bramba-terraform"
    key                     = "terraform-docker-study/terraform.tfstate"
    region                  = "us-east-1"
    acl                     = "private"
    encrypt                 = true
  }
}