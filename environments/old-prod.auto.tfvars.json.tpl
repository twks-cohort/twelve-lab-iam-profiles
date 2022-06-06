{
  "create_iam_profiles": false,
  "aws_region": "us-east-1",
  "assume_role": "DPSTerraformRole",
  "account_id": "{{ twdps/di/svc/aws/dps-1/aws-account-id }}",
  "prod_account_id": "{{ twdps/di/svc/aws/dps-1/aws-account-id }}",
  "nonprod_account_id": "{{ twdps/di/svc/aws/dps-2/aws-account-id }}",
  "datadog_api_key": "{{ twdps/di/svc/datadog/api-key }}",
  "datadog_app_key": "{{ twdps/di/svc/datadog/app-key }}",
  "twdpsio_gpg_public_key_base64": "unused"
}
