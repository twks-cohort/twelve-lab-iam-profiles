

aws sts assume-role --output json --role-arn arn:aws:iam::090950721693:role/DPSTerraformRole --role-session-name test || echo 'sts failure!'
