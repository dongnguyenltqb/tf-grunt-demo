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

inputs = {
  vpc_id    = dependency.network.outputs.vpc_id
  subnet_id = dependency.network.outputs.vpc_public_subnets[0]
  name      = "k8sMasterNode"
  use_eip   = true
  allow_rules = [
    {
      port                     = "22"
      cidr_block               = ["0.0.0.0/0"]
      source_security_group_id = null
    },
    {
      port                     = "80"
      cidr_block               = ["0.0.0.0/0"]
      source_security_group_id = null
    },
    {
      port                     = "443"
      cidr_block               = ["0.0.0.0/0"]
      source_security_group_id = null
    }
  ]
  key_name   = "msi"
  public_key = file("../../../ssh-keys/eks.pub")
  tags = {
    Component = "k8sCluster"
  }
}