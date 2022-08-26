terraform {
  source = "../../..//code/components/ec2"
}

dependency "network" {
  config_path = "../network"
  mock_outputs = {
    vpc_id = "temporary-dummy-id"
    subnet = "temporary-dummy-id"
  }
}

inputs = {
  vpc_id = dependency.network.outputs.vpc_id
  subnet_id = dependency.network.outputs.subnet_id
}

include "dev" {
  path = find_in_parent_folders("dev.hcl")
}

include "root" {
  path = "${dirname("../../")}/terragrunt.hcl"
}

