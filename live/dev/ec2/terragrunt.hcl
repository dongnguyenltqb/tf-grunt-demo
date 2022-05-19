terraform {
  source = "../../..//code/components/ec2"
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

