terraform {
  source = "git::git@github.com:dongnguyenltqb/tf-grunt-demo.git//code/components/network?ref=v0.0.1"
}

include "root" {
  path = "${dirname("../../")}/terragrunt.hcl"
}