#!/usr/bin/env bash

terraform init
# secrethub run -- terraform output DPSSimpleServiceAccount_encrypted_aws_secret_access_key | base64 -d | gpg -dq --passphrase ${GPG_KEY_PASSPHRASE} | secrethub write twdps/di/svc/aws/dps-2/DPSSimpleServiceAccount/aws-secret-access-key
# secrethub run -- terraform output DPSSimpleServiceAccount_aws_access_key_id | sed 's/"//g' | secrethub write twdps/di/svc/aws/dps-2/DPSSimpleServiceAccount/aws-access-key-id

# write the non-prod service account credentials to secret store
access_key=$(terraform output DPSNonprodServiceAccount_encrypted_aws_secret_access_key | sed 's/"//g' | base64 -d | gpg -dq --passphrase ${GPG_KEY_PASSPHRASE})
access_key_id=$(terraform output DPSNonprodServiceAccount_aws_access_key_id | tr -d \\n | sed 's/"//g')
op item edit "twelve-aws" --vault cohorts DPSNonprodServiceAccount-aws-secret-access-key=$access_key DPSNonprodServiceAccount-aws-access-key-id=$access_key_id
