![bootstrap](https://img.shields.io/badge/phase-bootstrap-yellow.svg?style=flat)
# lab-iam-profiles

This is the first pipeline applied to a set of greenfield accounts.  

DPS-1  (prod)  
DPS-2  (nonprod)  

Initial manual bootstrap configuration in each account of a single group and user:  

Group: bootstrap-iam  (_iam privileges_)  
User: bootstrap-_acct_ (_used only for lab-iam-profiles pipeline_)

## configuration

Master Account = DPS-1  

DPS-1 will also be the production account. Normally, the master account is a separate account  
that has a limited set of auth and sec functions. Since DPS only has two accounts, it is  
pulling double-duty. Not a practice to follow with a client.  

In the master account the following elements are defined:  

_for infividual team members_

DPSTeamMemberGroup : standard group for individual users

After requesting SSO admin access, individual DPS AWS account users should create a 
standard IAM user with access credentials, and add it to the DPSTeamMemberGroup group.  

The team members group is configured to have ReadOnlyAccess to the master account.  
In addition, this group is   

_again, noting that DPS-1 functions as the prod sub-account, DPS-2 is the nonprod sub-account._



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
