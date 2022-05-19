terraform {
  source = "git::git@github.com:dongnguyenltqb/tf-grunt-demo.git//code/components/ec2?ref=v0.0.1"
}

dependency "network" {
  config_path = "../network"
}

inputs = {
  vpc_id = dependency.network.outputs.vpc_id
  subnet_id = dependency.network.outputs.subnet_id
}

include "root" {
  path = "${dirname("../../")}/terragrunt.hcl"
}