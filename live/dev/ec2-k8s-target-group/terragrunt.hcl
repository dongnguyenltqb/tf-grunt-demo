include "dev" {
  path = find_in_parent_folders("dev.hcl")
}

include "root" {
  path = "${dirname("../../")}/terragrunt.hcl"
}

terraform {
  source = "../../../components//target-group"
}

dependency "network" {
  config_path = "${get_terragrunt_dir()}/../network"
  mock_outputs = {
    vpc_id = "123"
  }
}

inputs = {
  vpc_cidr             = dependency.network.outputs.vpc_id
  name                 = "k8sNodeGroup"
  port                 = 30008
  protocol             = "HTTP"
  health_check_path    = "/"
  health_check_matcher = "200,404"
  tags = {
    Component = "k8sCluster"
  }
}