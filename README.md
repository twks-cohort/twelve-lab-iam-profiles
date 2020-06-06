![bootstrap](https://img.shields.io/badge/phase-bootstrap-yellow.svg?style=flat)
# ztw-iam-profiles

Current Version:  

Uses a single AWS account to provide a development-only environment. Will update configuration to support multiple accounts as that becomes necessary.  

Note: the `bootstrap` badge indicates automation that is required before standard ways of working are possible. In this case, one cannot assume a role without first creating the necessary policies, groups, etc. For now the, this access-and-permissions pipeline will use a twdps/di static machine identity from a bootstrap role with appropriate permission.
