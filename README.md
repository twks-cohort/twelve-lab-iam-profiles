![bootstrap](https://img.shields.io/badge/phase-bootstrap-yellow.svg?style=flat)
# ztw-iam-profiles

Current Version:  

Uses a single AWS account to provide a development-only environment. Will update configuration to support multiple accounts as that becomes necessary.  

Note: the `bootstrap` badge indicates automation that is required before standard ways of working are possible. In this case, one cannot assume a role without first creating the necessary policies, groups, etc. For now the, this access-and-permissions pipeline will use a twdps/di static machine identity from a bootstrap role with appropriate permission.

## configuration

Creates two groups:  

ztw-devs
ztw-machine-accounts

Both have full ReadOnly access to all resources and settings and are able to assume the ZTWTerraformRole

While this is in the early stages, a simplified hierarchy will help limit the amount of operational overhead. We must all exercise respect for the level of permissions granted to the entire team, but with the real power in the assumed role, actual change must be intentional.
