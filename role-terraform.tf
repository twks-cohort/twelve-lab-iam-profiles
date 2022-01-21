module "DPSTerraformRole" {
  create_role = true
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"
  version = "~> 4.10.1"

  role_name = "DPSTerraformRole"
  role_requires_mfa = false
  custom_role_policy_arns = ["arn:aws:iam::aws:policy/AdministratorAccess"]

  trusted_role_arns = [
    "arn:aws:iam::${var.nonprod_account_id}:root",
    "arn:aws:iam::${var.prod_account_id}:root",
  ]
}
