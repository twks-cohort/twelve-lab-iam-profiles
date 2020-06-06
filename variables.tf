terraform {
  required_version = "~> 0.12"
  required_providers {
    aws = "~> 2.65"
  }

  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "ztw"
    workspaces {
      prefix = "ztw-iam-profiles-"
    }
  }
}

provider "aws" {
  version = "~> 2.0"
  region  = var.aws_region
}

variable "aws_region" { default = "us-east-1" }

variable "account_id" {}
