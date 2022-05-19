terraform {
  source = "git::git@github.com:dongnguyenltqb/tf-grunt-demo.git//code/components/ec2?ref=v0.0.1"
}

include "root" {
  path = "${dirname("../../")}/terragrunt.hcl"
}