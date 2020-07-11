![bootstrap](https://img.shields.io/badge/phase-bootstrap-yellow.svg?style=flat)
# lab-iam-profiles

This is the first pipeline applied to a set of greenfield accounts.  

DPS-1  (prod)  
DPS-2  (nonprod)  

Initial manual bootstrap configuration in each account of a single group and user:  

Group: bootstrap-iam  (_iam privileges_)  
User: bootstrap-_acct_ (_used only for lab-iam-profiles pipeline_)

## configuration

Non-production Account = DPS-1 (090950721693)  

Normally, a separate, user/role profile account exists to keep SSO and service accounts  
completely separate from all other aws resources. Since DPS only has two accounts, it is  
pulling double-duty. Not a practice to follow with a client.  

_for individual team members_

DPSTeamMemberGroup : standard group for both human and machine users

After requesting SSO admin access, individual DPS AWS account users should create a  
standard IAM user with access credentials, and add it to the DPSTeamMemberGroup group.  
Do not create programmatic access for your SSO integrated identity.  

The DPSTeamMemberGroup is configured to be able to assume ReadOnly or Terraform roles  
in both nonprod and prod. (substitute the appropriate account id) 

arn:aws:iam::0123456789:role/DPSReadOnlyRole
arn:aws:iam::0123456789:role/DPSTerraformRole

_platform AWS service account_

Under this 'simplistic' service account configuration, a single service (or machine user)  
accounts had been created to use for all infrastructure automation pipelines.  

### initial service account

DPSSimpleServiceAccount  

The `nonprod` env steps create the DPSSimpleServiceAccount identity in the nonprod account,  
storing credentials in secrethub.io. This service account is then added to the  
DPSTeamMemberGroup. Use this account to assume the above roles in infra-pipelines.  

---
