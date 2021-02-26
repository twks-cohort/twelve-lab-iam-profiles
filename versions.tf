terraform {
  required_version = "~> 0.14"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
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
