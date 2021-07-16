# is the plan/apply running against the profiles account?
variable "create_iam_profiles" {
  type     = bool
  default  = false
}

variable "aws_region" {}
variable "account_id" {}
variable "prod_account_id" {}
variable "nonprod_account_id" {}

# twdps.io@gmail.com service account gpg public key for encrypting aws credentials
variable "twdpsio_gpg_public_key_base64" {
  type        = string
  sensitive   = true
}
