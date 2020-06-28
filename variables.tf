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

variable "prod_account_id" {}
variable "nonprod_account_id" {}
variable "twdpsio_gpg_public_key_base64" {}
