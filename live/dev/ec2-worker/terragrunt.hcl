include "dev" {
  path = find_in_parent_folders("dev.hcl")
}

include "root" {
  path = "${dirname("../../")}/terragrunt.hcl"
}

terraform {
  source = "../../../components//ec2"
}

dependency "network" {
  config_path = "${get_terragrunt_dir()}/../network"
  mock_outputs = {
    vpc_id             = "vpc_id"
    vpc_public_subnets = ["a", "b", "c"]
  }
}

dependency "nodegroup_sg" {
  config_path = "${get_terragrunt_dir()}/../ec2-k8s-group-sg"
  mock_outputs = {
    security_group_id = "sg"
  }
}

dependency "nodegroup" {
  config_path = "${get_terragrunt_dir()}/../ec2-k8s-target-group"
  mock_outputs = {
    target_group_arn = "tg"
  }
}

dependency "master" {
  config_path = "${get_terragrunt_dir()}/../ec2-master"
  mock_outputs = {
    security_group_id = "sg"
  }
}

inputs = {
  vpc_id                        = dependency.network.outputs.vpc_id
  subnet_id                     = dependency.network.outputs.vpc_public_subnets[0]
  name                          = "k8sWorkerNode"
  use_eip                       = true
  additional_security_group_ids = [dependency.nodegroup_sg.outputs.security_group_id]
  target_groups = [{
    target_group_arn = dependency.nodegroup.outputs.target_group_arn
    port             = "30008"
  }]
  allow_rules = [
    {
      from_port                = "22"
      to_port                  = "22"
      protocol                 = "tcp"
      cidr_block               = null
      source_security_group_id = dependency.master.outputs.security_group_id
    }
  ]
  key_name   = "msiworker"
  public_key = file("../../../ssh-keys/worker.pub")
  tags = {
    Component = "k8sCluster"
  }
}