![bootstrap](https://img.shields.io/badge/phase-bootstrap-yellow.svg?style=flat)
# lab-iam-profiles

This is the first pipeline applied to a set of greenfield accounts.  

DPS-1  (prod)  
DPS-2  (nonprod)  

Initial manual bootstrap configuration in each account of a single group and user:  

Group: bootstrap-iam  (_iam privileges_)  
User: bootstrap-_acct_ (_used only for lab-iam-profiles pipeline_)

## configuration

_for infividual team members_

DPSTeamMemberGroup : standard group for individual users

After requesting SSO admin access, individual DPS account users can create a 
standard IAM user with access credentials, adding the identity to this group.

_for platform AWS service accounts_

DPSSimpleServiceAccountGroup

Under a 'simplistic' service account configuration, this group is configured to enable the  
service-account added to assume the roles defined in the participating accounts.  

To start - only two role types are provided:  

DPSTerraformUser : write/admin  
DPSReadOnlyUser : read/test  

### initial service account

DPSSimpleServiceAccount  

The `master` env steps create the DPSSimpleServiceAccount identity in the master account,  
storing credentials in secrethub.io. This service account is added to the  
DPSSimpleServiceAccountGroup

---
