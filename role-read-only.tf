# ReadOnly Role
resource "aws_iam_role" "DPSReadOnlyRole" {
  name = "DPSReadOnlyRole"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": {
    "Effect": "Allow",
    "Principal": { "AWS": "arn:aws:iam::${var.nonprod_account_id}:root" },
    "Action": "sts:AssumeRole"
  }
}
EOF
}

resource "aws_iam_policy_attachment" "attachment_DPSReadonlyRolePolicy_to_DPSReadOnlyRole" {
  name = "DPSReadonlyRolePolicy_attachment"
  roles = [aws_iam_role.DPSReadOnlyRole.name]
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}
