output "DPSAWSUser_aws_access_key_id" {
  value = aws_iam_access_key.DPSAWSUser.id
  sensitive   = true
  description = "service-account aws-access-key-id"
}

output "DPSAWSUser_encrypted_aws_secret_access_key" {
  value = aws_iam_access_key.DPSAWSUser.encrypted_secret
  sensitive   = true
  description = "gpg public key encrypted version of service-account aws-secret-access-key"
}
