module "DPSPlatformHostedZonesRole" {
  source      = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"
  version     = "~> 5.1"
  create_role = true

  role_name                         = "DPSPlatformHostedZonesRole"
  role_requires_mfa                 = false
  custom_role_policy_arns           = [aws_iam_policy.DPSPlatformHostedZonesRolePolicy.arn]
  number_of_custom_role_policy_arns = 1

  trusted_role_arns = ["arn:aws:iam::${var.nonprod_account_id}:root"]
}


resource "aws_iam_policy" "DPSPlatformHostedZonesRolePolicy" {
  name = "DPSPlatformHostedZonesRolePolicy"
  path = "/"

  policy = jsonencode({
    "Version": "2012-10-17"
    "Statement": [
      {
        "Action": [
        "route53:AssociateVPCWithHostedZone",
        "route53:ChangeResourceRecordSets",
        "route53:ChangeTagsForResource",
        "route53:GetChange",
        "route53:CreateHealthCheck",
        "route53:CreateHostedZone",
        "route53:CreateKeySigningKey",
        "route53:CreateVPCAssociationAuthorization",
        "route53:DeactivateKeySigningKey",
        "route53:DeleteHealthCheck",
        "route53:DeleteHostedZone",
        "route53:DeleteKeySigningKey",
        "route53:DeleteVPCAssociationAuthorization",
        "route53:DisassociateVPCFromHostedZone",
        "route53:GetHostedZone",
        "route53:GetHostedZoneCount",
        "route53:GetHostedZoneLimit",
        "route53:ListHostedZones",
        "route53:ListHostedZonesByName",
        "route53:ListHostedZonesByVPC",
        "route53:ListResourceRecordSets",
        "route53:ListTagsForResource",
        "route53:ListTagsForResources",
        "route53:ListVPCAssociationAuthorizations",
        "route53:UpdateHostedZoneComment"
        ]
        "Effect": "Allow"
        "Resource": "*"
      },
    ]
  })
}
