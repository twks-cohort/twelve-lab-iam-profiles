<div align="center">
	<p>
		<img alt="CircleCI Logo" src="https://github.com/ThoughtWorks-DPS/lab-documentation/blob/master/doc/img/dps-lab.png?sanitize=true" width="75" />
	</p>
  <h3>ThoughtWorks DPS Lab</h3>
  <h5>lab-iam-profiles</h5>
</div>
<br />

Given access to a complete suite of saas development tools*, the first step in a greenfield development is to bootstrap automation identity and permissions.  

<div align="center">
	<p>
		<img alt="CircleCI Logo" src="https://github.com/ThoughtWorks-DPS/lab-iam-profiles/blob/master/doc/aws_account_strategy.png" />
	</p>
</div>

One of the accounts is a dedicated identity and audit state store. Bootstrap of the accounts means creating a minimal iam groups, roles, and service account structure. Once deployed, this pipeline can then incorporated the results of it's own configuration and enable the teams to create pipeline specific roles as needed throughout ongoing development.  

**bootstrap step** manually create a bootstrap-group with iam:* permissions, and a bootstrap-user with programmatic credentials that is added to this group. Use these credentials to perform the inital creation of this iaim-profiles pipeline. Once the first iteration of the pipeline is stable, reconfigure the pipeline to subtitute the new service-account-nonprod credentials and assume the associated iam-profiles role. The bootstrap-user credentials are now deleted, though the bootstrap role and user can be retained. Should the need arise in the future to re-bootstrap the iam-profiless role, new bootstrap access keys can be generated.  

The `state` account is the only account that will contain iam:group and iam:user resources. As the drawing below indicates, nonprod and prod service accounts are created to act as the indentity for all infrastructure pipelines. There are matching groups defined that enable the service accounts to assume any role matching the service-account-role naming pattern in the respective aws accounts. There is also a platform team members groups created the enable the owners of these accounts to assume any role in any accounts for development and forensic purposes. _note. production access is a necessary part of product ownership, and for compliance purposes monitoring and alerts are configured for the production account to track and notify regarding platform team direct access to the production account._

<div align="center">
	<p>
		<img alt="CircleCI Logo" src="https://github.com/ThoughtWorks-DPS/lab-iam-profiles/blob/master/doc/configuration.png" />
	</p>
</div>

This lab example simplifies the configuration to present just the resource configuration methods and uses only two accounts.    

DPS-2  (nonprod)  
DPS-1  (prod)  

## configuration

_group_

DPSTeamMemberGroup : single group for both team members and a service account.  

The DPSTeamMemberGroup is configured to be able to assume ReadOnly or Terraform roles  
in both nonprod and prod. (substitute the appropriate account id) 

_roles_

The simple TerraformRole demosntrates the basic resource configuration process. Adopt pipeline rbac limitations for an actual implementation.  

arn:aws:iam::0123456789:role/DPSReadOnlyRole  
arn:aws:iam::0123456789:role/DPSTerraformRole  

_service account_

A single service account (or machine user) has been created to use for all infrastructure automation pipeline examples.  

DPSSimpleServiceAccount    

#### Maintainers

Internal developer guides and run-books for DPS lab environments are [here](https://github.com/ThoughtWorks-DPS/documentation-internal).  

*saas tools used for this pipeline
* secrethub (secrets management)
* terraform cloud (backend state store)
* circleci (pipeline orchestration)
  * dockerhub (pipeline executors)
