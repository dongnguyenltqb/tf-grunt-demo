module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = var.vpc_name
  cidr = var.vpc_cidr

  azs             = data.aws_availability_zones.available.names
  private_subnets = var.vpc_private_subnets
  public_subnets  = var.vpc_public_subnets

  enable_dns_hostnames = true

  single_nat_gateway = true
  enable_nat_gateway = true
  enable_vpn_gateway = false

  tags = merge(local.tags, var.tags)
}

data "aws_availability_zones" "available" {
  state = "available"
}
