#!/usr/bin/env bats

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
