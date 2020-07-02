#!/usr/bin/env bats

@test "confirm iam roles" {
  run bash -c "aws iam list-roles"
  [[ "${output}" =~ "DPSReadOnlyRole" ]]
  [[ "${output}" =~ "DPSTerraformRole" ]]
}

@test "confirm iam policies" {
  run bash -c "aws iam list-policies"
  [[ "${output}" =~ "DPSTerraformRolePolicy" ]]
}

@test "confirm policy attached to DPSTerraformRole" {
  run bash -c "aws iam list-attached-role-policies --role-name DPSTerraformRole"
  [[ "${output}" =~ "DPSTerraformRolePolicy" ]]
}

@test "confirm policy attached to DPSReadOnlyRole" {
  run bash -c "aws iam list-attached-role-policies --role-name DPSReadOnlyRole"
  [[ "${output}" =~ "ReadOnlyAccess" ]]
}
