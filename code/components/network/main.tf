module "network" {
  source      = "../../modules/vpc"
  cidr_block  = var.cidr_block
  subnet_cidr = var.subnet_cidr
}
