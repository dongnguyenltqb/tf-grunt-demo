terraform {
  source = "../../..//code/components/network"
}

include "root" {
  path = "${dirname("../../")}/terragrunt.hcl"
}