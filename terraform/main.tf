terraform {
  backend "s3" {
    bucket = "klaudtech.co.ke"
    key    = "klaudtech-ansible.tfstate"
    region = "us-east-2"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.0.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}