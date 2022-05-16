terraform {
  source = "../../..//code/components/network"
}

// load env for each component
include "environment" {
  path = find_in_parent_folders()
}

include "root" {
  path = "${dirname("../../")}/terragrunt.hcl"
}