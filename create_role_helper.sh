#!/usr/bin/env bash

# $1 is the role name
cat <<EOF > role-${1}.tf
module "${1}Policy" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-policy"
  version = "~> 4.7"

  name    = "${1}Policy"
  policy  = file("./policy/${1}Policy.json")
}

module "${1}" {
  create_role = true
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"
  version = "~> 4.1"

  role_name = "${1}"
  role_requires_mfa = false
  custom_role_policy_arns = ["arn:aws:iam::aws:policy/${1}Policy"]

  trusted_role_arns = [
    "arn:aws:iam::\${var.nonprod_account_id}:root",
    "arn:aws:iam::\${var.prod_account_id}:root",
  ]
}
EOF

cat <<EOF > policy/${1}.json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Deny",
      "Resource": "*"
    }
  ]
}
EOF

cat <<EOF > test/iam-roles/controls/${1}.rb
title "${1}"

describe aws_iam_role(role_name: '${1}') do
  it { should exist }
end

describe aws_iam_policy(policy_name: '${1}Policy') do
  it { should exist }
  its ('attached_roles') { should cmp '${1}' }
end
EOF

echo 'edit the ${1}.json policy document to define permissions for the new role'
