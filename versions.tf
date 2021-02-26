terraform {
  required_version = "~> 0.13"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      #version = "~> 2.70"
    }
  }

  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "twdps"
    workspaces {
      prefix = "lab-iam-profiles-"
    }
  }
}

provider "aws" {
  region = var.aws_region
}
