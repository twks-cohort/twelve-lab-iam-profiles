terraform {
  required_version = "~> 1.1"
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

  # this section commented out during the initial bootstrap run
  # once the assumeable roles are created, uncomment and change
  # secrethub.*.env to contain the DPSSimpleServiceAccount identity
  assume_role {
    role_arn     = "arn:aws:iam::${var.account_id}:role/${var.assume_role}"
    session_name = "lab-iam-profiles"
  }
}
