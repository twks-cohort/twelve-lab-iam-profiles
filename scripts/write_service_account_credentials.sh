#!/usr/bin/env bash

secrethub run -- terraform output DPSSimpleServiceAccount_encrypted_aws_secret_access_key | base64 -d | gpg -dq --passphrase ${GPG_KEY_PASSPHRASE} | secrethub write twdps/di/svc/aws/dps-2/DPSSimpleServiceAccount/aws-secret-access-key
secrethub run -- terraform output DPSSimpleServiceAccount_aws_access_key_id | sed 's/"//g' | secrethub write twdps/di/svc/aws/dps-2/DPSSimpleServiceAccount/aws-access-key-id
