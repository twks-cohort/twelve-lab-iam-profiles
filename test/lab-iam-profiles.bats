#!/usr/bin/env bats

@test "confirm iam service accounts" {
  run bash -c "secrethub run -- aws iam list-users"
  [[ "${output}" =~ "DPSAWSUser" ]]
}

@test "confirm iam groups" {
  run bash -c "secrethub run -- aws iam list-groups"
  [[ "${output}" =~ "DPSTeamMemberGroup" ]]
  [[ "${output}" =~ "DPSSimpleServiceAccountGroup" ]]
}

@test "confirm policy attached to DPSSimpleServiceAccountGroup" {
  run bash -c "secrethub run -- aws iam list-group-policies --group-name DPSSimpleServiceAccountGroup"
  [[ "${output}" =~ "AssumeDPSSimpleServiceAccountRolePolicy" ]]
}

@test "confirm policy attached to DPSTeamMemberGroup" {
  run bash -c "secrethub run -- aws iam list-attached-group-policies --group-name DPSTeamMemberGroup"
  [[ "${output}" =~ "ReadOnlyAccess" ]]
}

@test "evaluate policy attached to AssumeDPSSimpleServiceAccountRolePolicy" {
  run bash -c "secrethub run -- aws iam get-group-policy --policy-name AssumeDPSSimpleServiceAccountRolePolicy --group-name DPSSimpleServiceAccountGroup"
  [[ "${output}" =~ "090950721693:role/DPSTerraformRole" ]]
  [[ "${output}" =~ "090950721693:role/DPSReadOnlyRole" ]]
  [[ "${output}" =~ "481538974648:role/DPSTerraformRole" ]]
  [[ "${output}" =~ "481538974648:role/DPSReadOnlyRole" ]]
}

# @test "evaluate iam roles" {
#   run bash -c "aws iam list-roles"
#   [[ "${output}" =~ "DPSReadOnlyRole" ]]
#   [[ "${output}" =~ "DPSTerraformRole" ]]
# }

# @test "confirm iam policies" {
#   run bash -c "secrethub run -- aws iam list-policies"
#   [[ "${output}" =~ "DPSReadOnlyRolePolicy" ]]
#   [[ "${output}" =~ "DPSTerraformRolePolicy" ]]
# }
