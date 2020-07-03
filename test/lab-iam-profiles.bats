#!/usr/bin/env bats

@test "confirm iam service accounts" {
  run bash -c "aws iam list-users"
  [[ "${output}" =~ "DPSSimpleServiceAccount" ]]
}

@test "confirm iam groups" {
  run bash -c "aws iam list-groups"
  [[ "${output}" =~ "DPSTeamMemberGroup" ]]
}

@test "confirm policy attached to DPSTeamMemberGroup" {
  run bash -c "aws iam list-group-policies --group-name DPSTeamMemberGroup"
  [[ "${output}" =~ "AssumeDPSSimpleServiceAccountRolePolicy" ]]
}

@test "evaluate policy attached to DPSTeamMemberGroup" {
  run bash -c "aws iam get-group-policy --policy-name AssumeDPSSimpleServiceAccountRolePolicy --group-name DPSTeamMemberGroup"
  [[ "${output}" =~ "1693:role/DPSTerraformRole" ]]
  [[ "${output}" =~ "1693:role/DPSReadOnlyRole" ]]
  [[ "${output}" =~ "4648:role/DPSTerraformRole" ]]
  [[ "${output}" =~ "4648:role/DPSReadOnlyRole" ]]
}

