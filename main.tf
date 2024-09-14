terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.66.0"
    }
  }

  required_version = "~> 1.9.5"
}

provider "aws" {
  region     = var.aws_region
  access_key = ""
  secret_key = ""
  token = ""
}

