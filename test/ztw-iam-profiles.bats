#!/usr/bin/env bats

@test "evaluate iam policies" {
  run bash -c "aws iam list-policies"
  [[ "${output}" =~ "ZTWReadOnlyRolePolicy" ]]
  [[ "${output}" =~ "ZTWTerraformRolePolicy" ]]
}

@test "evaluate iam roles" {
  run bash -c "aws iam list-roles"
  [[ "${output}" =~ "ZTWReadOnlyRole" ]]
  [[ "${output}" =~ "ZTWTerraformRole" ]]
}
