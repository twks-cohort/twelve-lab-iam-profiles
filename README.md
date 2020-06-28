![bootstrap](https://img.shields.io/badge/phase-bootstrap-yellow.svg?style=flat)
# lab-iam-profiles

Lab profile pipeline assumes starting from a minimum manual configuration.

DPS-1  (production)
DPS-2  (nonprod)

For bootstrap configuration, each account is manually configured with a single group and user:

Group:
  bootstrap-iam  # has full iam privileges

User:
  bootstrap-prod  # or nonprod

## configuration

_for human users_

DPSTeamMemberGroup : standard group for individual users

DPS account users, after requesting SSO admin access, individual DPS account users create a 
standard IAM user with access credentials, adding the identity to this group.

_for platform AWS service accounts_

DPSSimpleServiceAccountGroup

Under a 'simplistic' service account configuration, this group is configuraed to enable the  
service-account members to assume all roles in the participating accounts.  

To start - only two role types are provided:

DPSTerraformUser : write/admin  
DPSReadOnlyUser : read/test  

## initial service account

DPSAWSUser  

Credentials stored in secrethub.io  

