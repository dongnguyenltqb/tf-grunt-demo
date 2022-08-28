include "dev" {
  path = find_in_parent_folders("dev.hcl")
}

include "root" {
  path = "${dirname("../../")}/terragrunt.hcl"
}

terraform {
  source = get_terragrunt_dir()
}

dependency "network" {
  config_path = "${get_terragrunt_dir()}/../network"
  mock_outputs = {
    vpc_cidr           = "1.2.3.4/5"
    vpc_id             = "vpc_id"
    vpc_public_subnets = ["a", "b", "c"]
  }
}

inputs = {
  vpc_id      = dependency.network.outputs.vpc_id
  name        = "k8sClusteNodeSg"
  description = "a sg to allow all traffic in all node in cluster"
  tags = {
    Component = "k8sCluster"
  }
}