terraform {
  required_version = "~> 0.12.28"
  required_providers {
    aws = "~> 2.70"
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
  region  = var.aws_region
}

variable "is_iam_users_account" {}
variable "aws_region" {}
variable "prod_account_id" {}
variable "nonprod_account_id" {}
variable "twdpsio_gpg_public_key_base64" {}
