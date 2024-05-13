{
  "create_iam_profiles": true,
  "is_prod_account": false,
  "aws_default_region": "ap-southeast-2",
  "aws_account_role": "DPSIamProfilesRole",
  "aws_account_id": "{{ op://cohorts/twelve-aws/aws-account-id }}",

  "aws_region": "ap-southeast-2",
  "assume_role": "DPSIamProfilesRole",
  "account_id": "{{ op://cohorts/twelve-aws/aws-account-id }}",
  "nonprod_account_id": "{{ op://cohorts/twelve-aws/aws-account-id }}",
  "twdpsio_gpg_public_key_base64": "{{ op://cohorts/alpha-svc-gpg/public-key-base64 }}"
}
