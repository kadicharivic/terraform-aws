terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "YOUR AWS REGION"
  secret_key = "YOUR AWS SECRET KEY"
  access_key = "YOUR AWS ACCESS KEY ID"
}

