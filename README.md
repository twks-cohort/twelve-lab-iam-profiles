<div align="center">
	<p>
		<img alt="Thoughtworks Logo" src="https://raw.githubusercontent.com/ThoughtWorks-DPS/static/master/thoughtworks_flamingo_wave.png?sanitize=true" width=200 />
    <br />
		<img alt="DPS Title" src="https://raw.githubusercontent.com/ThoughtWorks-DPS/static/master/dps_lab_title.png?sanitize=true" width=350/>
	</p>
  <h3>lab-iam-profiles</h3>
</div>
<br />

Given access to a complete suite of saas development tools*, the first step in a greenfield development is to bootstrap automation identity and permissions.  

<div align="center">
	<p>
		<img alt="CircleCI Logo" src="https://github.com/ThoughtWorks-DPS/lab-iam-profiles/blob/main/doc/aws_account_strategy.png" />
	</p>
</div>

The `state` account is a dedicated defining identities, groups, memberships and as the long-term home of aggregated audit log information.  

The iam-profiles pipeline manages the creation of the iam structures in the state account. It also manages the creation and propogation of roles. The same set of roles should exist across all the accounts. Groups are used to define which Users (service accounts or team members) are permitted to assume which role in a given account.  

**bootstrap step** manually create a bootstrap-group with iam:* permissions, and a bootstrap-user with programmatic credentials that is added to this group. Use these credentials to perform the inital creation of this iaim-profiles pipeline. Once the first iteration of the pipeline is stable, reconfigure the pipeline to subtitute the new service-account-nonprod credentials and assume the associated iam-profiles role. The bootstrap-user credentials are now deleted, though the bootstrap role and user can be retained. Should the need arise in the future to re-bootstrap the iam-profiless role, new bootstrap access keys can be generated.  

The `state` account is the only account that will contain iam:group and iam:user resources. A basic example drawing below illustrates, nonprod and prod service accounts are created to act as the indentity for all infrastructure pipelines. There are matching groups defined that enable the service accounts to assume any role matching the service-account-role naming pattern in the respective aws accounts. There is also a platform team members groups created the enable the owners of these accounts to assume any role in any accounts for development and forensic purposes. _note. production access is a necessary part of product ownership, and for compliance purposes monitoring and alerts are configured for the production account to track and notify regarding platform team direct access to the production account._

<div align="center">
	<p>
		<img alt="CircleCI Logo" src="https://github.com/ThoughtWorks-DPS/lab-iam-profiles/blob/main/doc/configuration.png" />
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
