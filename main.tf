# ReadOnly Role
resource "aws_iam_policy" "ReadonlyRolePolicy" {
  name = "ZTWReadOnlyRolePolicy"
  path = "/"
  policy = file("./policy/ReadOnlyRolePolicy_1.0.json")
}

resource "aws_iam_role" "ReadOnlyRole" {
  name = "ZTWReadOnlyRole"
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

resource "aws_iam_policy_attachment" "attachment_readonly_role_readonly_role" {
  name = "readonly_policy_attachment"
  roles = [aws_iam_role.ReadOnlyRole.name]
  policy_arn = aws_iam_policy.ReadonlyRolePolicy.arn
}

# Terraform User Role
resource "aws_iam_policy" "TerraformRolePolicy" {
  name = "ZTWTerraformRolePolicy"
  path = "/"
  policy = file("./policy/TerraformRolePolicy_1.0.json")
}

resource "aws_iam_role" "TerraformRole" {
  name = "ZTWTerraformRole"
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

resource "aws_iam_policy_attachment" "attachment_terraform_role_policy_to_terraform_role" {
  name = "terraform_policy_attachment"
  roles = [aws_iam_role.TerraformRole.name]
  policy_arn = aws_iam_policy.TerraformRolePolicy.arn
}
