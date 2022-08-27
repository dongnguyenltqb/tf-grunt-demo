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

dependency "master" {
  config_path = "${get_terragrunt_dir()}/../ec2-master"
  mock_outputs = {
    security_group_id = "sg"
  }
}

inputs = {
  vpc_id    = dependency.network.outputs.vpc_id
  subnet_id = dependency.network.outputs.vpc_public_subnets[0]
  name      = "k8sWorkerNode"
  use_eip   = true
  allow_rules = [
    {
      from_port                = "22"
      to_port                  = "22"
      protocol                 = "tcp"
      cidr_block               = ["0.0.0.0/0"]
      source_security_group_id = null
    },
    {
      from_port                = "0"
      to_port                  = "65535"
      protocol                 = "-1"
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