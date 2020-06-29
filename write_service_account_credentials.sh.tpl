#!/usr/bin/env bash

# write DPSSimpleServiceAccount credentials
if !(secrethub tree twdps/di/svc/aws/dps-1 | grep -q "DPSSimpleServiceAccount"); then
    secrethub mkdir twdps/di/svc/aws/dps-1/DPSSimpleServiceAccount
fi
secrethub run -- terraform output DPSSimpleServiceAccount_encrypted_aws_secret_access_key | base64 -d | gpg -dq --passphrase {{ twdps/di/svc/gpg/passphrase }} | secrethub write twdps/di/svc/aws/dps-1/DPSSimpleServiceAccount/aws-secret-access-key
secrethub run -- terraform output DPSSimpleServiceAccount_aws_access_key_id | base64 -d | gpg -dq --passphrase {{ twdps/di/svc/gpg/passphrase }} | secrethub write twdps/di/svc/aws/dps-1/DPSSimpleServiceAccount/aws-access-key-id
