terraform {
  required_version = "~> 0.12"
  required_providers {
    aws = "~> 2.68"
  }

  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "twdps"
    workspaces {
      prefix = "twdps-iam-profiles-"
    }
  }
}

provider "aws" {
  version = "~> 2.0"
  region  = var.aws_region
}

variable "aws_region" {}

variable "account_id" {}
