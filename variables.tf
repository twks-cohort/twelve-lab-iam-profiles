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

variable "aws_region" { default = "us-east-1" }

variable "prod_account_id" { default = "481538974648" }
variable "nonprod_account_id" { default = "090950721693" }
variable "twdpsio_pgp_public_key" { default = "mQINBF73uWABEAC+IjzjAPM2xZLO9j+t4A+09/hyU/qJTMkepoMQdQ2j4X/pX3bAlfyiJ9ZsKTST3xpiTSJgFuSa1sGSh+hSRntg/olb9yShZ8GMooKRU+l0ddLKiOBSRjRh1BM7tCJQNwgAIO0pj54E16SnfRhz/XBDZ+RYuiPS/EneGwoNtWdvn/NqolXoUyMANnw+gz1NnOrOFMYnJaeuLOvk8JZVUwRMb/9vTJtxwdxMYnKNgEdHANwVesT5fhhqkrp9LaUpt8jxS8HUXTevm/ANF1onfx91PeZEsjiloDXxzM6Y5D/7Zz6enqf3aLJfXgTWCZ5gyYhuuH7Adw46BO6HDRE9Aa4VzqPwNoT1pNkUprglELYwEaaqS17j8t/JJWoeLl9bCpk8HxpdasqV7yBVyfSY8YsedRrHQjUqRouSTxqVkIDMq4zzTrC1CXOoxWRZrVkntr+hTO8hGvsmRRiyX+k8YXPvCckJAFTPcc0qsKnR5rhSUNTxhEvJDaC9kR7OnIvn7RuqO7S8FeTHo3Gzlhmv6YNMAD3OyH4qZXg2zv6wKKAQIce6gfbkDoMWWkV1Odih5uuzfFwGELGoK6LV9YJm4CU47so1M6RDGmKY0wX0lsjnef9Jn8AZLd1XRV2kVzXnFVHEpfVf9pT+NhWYXPWTEqDPHQSm4XJAoyyzy7Oq+fiXOQARAQABtC10d2Rwcy5pbyBzZXJ2aWNlIGFjY291bnQgPHR3ZHBzLmlvQGdtYWlsLmNvbT6JAk4EEwEIADgWIQR8zxnM/4q+7EVkeQqrvliwfsJNQQUCXve5YAIbDwULCQgHAgYVCgkICwIEFgIDAQIeAQIXgAAKCRCrvliwfsJNQV7KEACu5OQuD1Xc8pJlnFiOlxbZlqB5nBIUzfl+4aSCvTrGsAPDyS21F+4qtrXFy1VQs6dzpicJGe0UE6corlB7YeHotB1GDkhZMbqZCbHQEcN57blaVgq9xjNFUo7H1iQUYOc4sKrtCKSFwMbN4BgWYxFHou+UdSMc/d/2z7wJHVc+isf0wEwB2aKBirRB+Ye+YyEsTC1HMJE16jUra3c0yWqsfzo4zRSKHcRTrY4/9HppERBKKydcfJcJW5NrU4/3j2oFUmzxy1g8NQYzEdipRO3Awg/A+9jXrUp6/YgL1enNjLDGs5nXsiq3q3dPd6HEq5DIw9LrNK2V7Rz2ZVcd8l/jhZY4wp9PxEpGm0pBGEP2SyY3xXmNJUfhzCrO5p4QYARu7epT+lDiPtkBGCE81HcWreLGTlEJ8Qenmke7TxxcrL1JFkUJqoUAQVaNcQArEpL8/oOUQgpLC57bnHS8aPPswwAg84To4dNLMkz66QF/pW9lHsKhpts3lSxmzkTXG3fVzbyM29e9T5Pa/mmv+H5hLzcv62NPRQl+VkMgWQwPD9YoruLjL/T3EIJfc0th5lMjFPNXFUzUywD4k91Oda8woaTUbLK4MxXe7LI3bEM7ajQW+FJLBCdol+flAPKXJTCZzYyNBd+j2LS/Xww+HlyzGeiH6VqIimTohjGxTQoLkg==" }

