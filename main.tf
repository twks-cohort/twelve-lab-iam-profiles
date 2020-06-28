# default user group
resource "aws_iam_group" "DPSTeamMemberGroup" {
  name = "DPSTeamMemberGroup"
}

resource "aws_iam_group_policy_attachment" "attach_ReadOnlyAccess" {
  group      = aws_iam_group.DPSTeamMemberGroup.name
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}

# simplified service account group
#
# in this configuration, the service account group is configured to let
# the svc accout assume multiple roles based on need
resource "aws_iam_group" "DPSSimpleServiceAccountGroup" {
  name = "DPSSimpleServiceAccountGroup"
}

resource "aws_iam_group_policy" "AssumeDPSSimpleServiceAccountRolePolicy" {
  name = "AssumeDPSSimpleServiceAccountRolePolicy"
  group = aws_iam_group.DPSSimpleServiceAccountGroup.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "sts:AssumeRole",
      "Resource": [
        "arn:aws:iam::${var.nonprod_account_id}:role/DPSTerraformRole",
        "arn:aws:iam::${var.nonprod_account_id}:role/DPSReadOnlyRole",
        "arn:aws:iam::${var.prod_account_id}:role/DPSTerraformRole",
        "arn:aws:iam::${var.prod_account_id}:role/DPSReadOnlyRole"
      ]
    }
  ]
}
EOF
}

# service accounts
resource "aws_iam_user" "DPSSimpleServiceAccount" {
  name = "DPSSimpleServiceAccount"
  path = "/"
}

resource "aws_iam_access_key" "DPSSimpleServiceAccount" {
  user    = aws_iam_user.DPSSimpleServiceAccount.name
  pgp_key = var.twdpsio_gpg_public_key_base64
}
