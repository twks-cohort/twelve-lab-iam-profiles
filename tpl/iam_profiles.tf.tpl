# simplified authorization model
#
# a single member group is defined, inclusion enabling the user or
# service account identity to assume either ReadOnly or Terraform  
# permissions in both DPS aws accounts

resource "aws_iam_group" "DPSTeamMemberGroup" {
  name = "DPSTeamMemberGroup"
}

resource "aws_iam_group_policy" "AssumeDPSSimplifiedAccountRolesPolicy" {
  name = "AssumeDPSSimplifiedAccountRolesPolicy"
  group = aws_iam_group.DPSTeamMemberGroup.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "sts:AssumeRole",
      "Resource": [
        "arn:aws:iam::${var.nonprod_account_id}:role/DPSReadOnlyRole",
        "arn:aws:iam::${var.nonprod_account_id}:role/DPSTerraformRole"
      ]
    },
    {
      "Effect": "Allow",
      "Action": "sts:AssumeRole",
      "Resource": [
        "arn:aws:iam::${var.prod_account_id}:role/DPSReadOnlyRole",
        "arn:aws:iam::${var.prod_account_id}:role/DPSTerraformRole"
      ]
    }
  ]
}
EOF
}

# simplified service account is a general purpose svc account
# used for all pipeline orchestration. Not recommended where
# there are multiple teams such as on client engagements
resource "aws_iam_user" "DPSSimpleServiceAccount" {
  name = "DPSSimpleServiceAccount"
  path = "/"
}

resource "aws_iam_access_key" "DPSSimpleServiceAccount" {
  user    = aws_iam_user.DPSSimpleServiceAccount.name
  pgp_key = var.twdpsio_gpg_public_key_base64
  depends_on = [aws_iam_user.DPSSimpleServiceAccount]
}

resource "aws_iam_user_group_membership" "DPSSimpleServiceAccount" {
  user = aws_iam_user.DPSSimpleServiceAccount.name
  groups = [aws_iam_group.DPSTeamMemberGroup.name]
  depends_on = [aws_iam_user.DPSSimpleServiceAccount, aws_iam_group.DPSTeamMemberGroup]
}




# resource "aws_iam_group_policy_attachment" "attach_ReadOnlyAccess" {
#   group      = aws_iam_group.DPSTeamMemberGroup.name
#   policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
# }
