<div align="center">
	<p>
		<img alt="Thoughtworks Logo" src="https://raw.githubusercontent.com/ThoughtWorks-DPS/static/master/thoughtworks_flamingo_wave.png?sanitize=true" width=200 />
    <br />
		<img alt="DPS Title" src="https://raw.githubusercontent.com/ThoughtWorks-DPS/static/master/dps_lab_title.png?sanitize=true" width=350/>
		<br />
		<a href="https://aws.amazon.com"><img src="https://img.shields.io/badge/-deployed-blank.svg?style=social&logo=amazon"></a>
		<br />
		<h3>lab-iam-profiles</h3>
		</a> <a href="https://app.circleci.com/pipelines/github/ThoughtWorks-DPS/circleci-remote-docker"><img src="https://circleci.com/gh/ThoughtWorks-DPS/circleci-remote-docker.svg?style=shield"></a>
		<a href="https://opensource.org/licenses/MIT"><img src="https://img.shields.io/github/license/ThoughtWorks-DPS/circleci-remote-docker"></a>
	</p>
</div>


This iam-profiles pipeline implements a secure, single platform team identity pattern that is assumed to be part of a broader product-centered identity architecture.  

While the number of team-bounded domains in a delivery infrastructure platform will grow from just one over time (depending on the number of development teams using the platform), the essential pattern for securing the permission boundary for _Users_ of the product involves seprating such user's identity, and authentication and authorization events, from the underlying IaaS providers native infrastructure identity.  

You see this pattern repeated across the SaaS and mobile marketplace. You are experiencing it right now as you read this file on github.com. As many people are aware, github.com is hosted on rackspace.com. Since being purchased by Microsoft, many new features are being hosted on Azure. When you use those new hosted GitHub Runners, you are not personally working from an Azure identity. You created a discrete github identity (or perhaps it was created for you through your organizational SSO integration with github). Github services use this _constomer identity_ to manage the data and services to which individual users have access.  

How this relates to a delivery infrastructure platform will become more apparent if you follow along in the dps-labs series of platform repos. For now, know that in the context of IAM users and the roles assumes by IAM users, a goal is to limit kinds and numbers of IAM users to just the Platform team itself and the service accounts used by the pipelines that orchestrate the provisioning and lifecycle management of the underlying infrastructure.  

**note**: Wby is this repo named `iam-profiles`? When using the AWS command-line tool to interact with Amazon Web Services, a users AWS Profile is used as a term to refer to the combination of the users AWS credentials, the particular role they wish to assume, and the AWS region to reference by default when processing user commands. Since this repo and pipeline are chiefly concerned with managing the service account identities and credentials and all the user-assumeable roles across the AWS accounts used by this delivery platform, the name iam-profiles is adopted as a team convention to identity the primary pipeline responsibilities. And it can be said that the `domain` of this pipeline is the management of IAM services accounts, and the roles that service accounts or platform developers may assume.  

#### starting point in an AWS setting

Account structure  

<div align="center">
	<p>
		<img alt="CircleCI Logo" src="https://github.com/ThoughtWorks-DPS/lab-iam-profiles/blob/main/doc/aws_account_strategy.png" />
	</p>
</div>

The `state` account is a dedicated account within which service accounts and non-federated platform delivery team members, groups, and group memberships are defined, and as an aggregation location for security audit log and other cross-account data that needs to be funneled into longer-term systems of record.  

The iam-profiles pipeline manages the creation of the service account iam user identities, the nonprod and prod iam groups, and membership attachment of iam user identites with one or both of those iam groups.  

In addition, it also manages the propogation of a common set of pipeline roles that exist in each of the platform accounts, e.g., the same set of roles exist across all the accounts. It is membership within one of the above groups that determines which accounts the iam user may assume said roles.  

The `sandbox` account is used only by the Platform team only. This account is where the continuous integration and testing of platform infrastructure takes place, prior to deployment in customer facing accounts.  

All customer, non-production workloads live in the `nonprod` account.  

The `prod` account is for customer, production workloads and for the custom, platform capability APIs.  

#### Development

_See the dependencies section below for a list of infrastructure and development services used by this implementation._  

**bootstrap step:** before a pipeline can successfully manage these resources across muiltiple accounts, the appropriate service accounts and groups, along with at least the role used by this pipeline must already exist. How do you deal with this chicken-or-egg situation?

Assuming you have access to the development dependencies listed below, the only AWS configuration necessary is to go to each account and, through the AWS management console, create a temporary service account with AdministratorAccess permissions and generate programmatic credentials.

Store those credentials to your secret store.  

You can now directly begin using the pipeline to deploy and testing the configuration from this repo. If you have all four recommended accounts, adjust the number of environments and resulting secret locations to match. It typically only takes a couple hours from start to finish to have the pipeline successfully managing the service accounts and roles.

At this point, the intended service accounts now exist and their credentials are available in the secrets store. DELETE the temporary service accounts and credentials and modify the secrets definition to now use the desired service accounts. You can see in the comments within the secrethub files here what that looks like.  

This situation is one of many where having available the development resources listed under dependencies below greatly simplifies this chick-or-egg situation. Now, without needing to provision or configure any compute or storage resources and without use of AWS credentials I can store and retrieve secrets, create and reference remote terrafrom state, and orchestrate all of the repo's infrastructure activities in a pipeline.  



manually create a bootstrap-group with iam:* permissions, and a bootstrap-user with programmatic credentials that is added to this group. Use these credentials to perform the inital creation of this iaim-profiles pipeline. Once the first iteration of the pipeline is stable, reconfigure the pipeline to subtitute the new service-account-nonprod credentials and assume the associated iam-profiles role. The bootstrap-user credentials are now deleted, though the bootstrap role and user can be retained. Should the need arise in the future to re-bootstrap the iam-profiless role, new bootstrap access keys can be generated.  

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

## DataDog

The aws account core integration to datadog is a external-id based role. This is a single role per aws account and in the lab is managed by this repo/pipeline since it bears the same attributes iam-profile roles in general.  

#### Dependencies

Internal developer guides and run-books for DPS lab environments are [here](https://github.com/ThoughtWorks-DPS/documentation-internal).  

*saas tools used for this pipeline
* 1password (secrets management)
* terraform cloud (backend state store)
* circleci (pipeline orchestration)
  * dockerhub (pipeline executors)
