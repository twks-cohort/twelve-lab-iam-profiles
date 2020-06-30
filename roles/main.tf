# Terraform User Role
resource "aws_iam_policy" "DPSTerraformRolePolicy" {
  name = "DPSTerraformRolePolicy"
  path = "/"
  policy = file("./policy/TerraformRolePolicy_1.0.json")
}

resource "aws_iam_role" "DPSTerraformRole" {
  name = "DPSTerraformRole"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": {
    "Effect": "Allow",
    "Principal": { "AWS": "arn:aws:iam::${var.account_id}:root" },
    "Action": "sts:AssumeRole"
  }
}
EOF
}

resource "aws_iam_policy_attachment" "attachment_DPSTerraformRolePolicy_to_DPSTerraformRole" {
  name = "DPSTerraformRolePolicy_attachment"
  roles = [aws_iam_role.DPSTerraformRole.name]
  policy_arn = aws_iam_policy.DPSTerraformRolePolicy.arn
}

# ReadOnly Role
resource "aws_iam_role" "DPSReadOnlyRole" {
  name = "DPSReadOnlyRole"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": {
    "Effect": "Allow",
    "Principal": { "AWS": "arn:aws:iam::${var.account_id}:root" },
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
