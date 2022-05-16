module "network" {
  source     = "../../modules/vpc"
  cidr_block = var.cidr_block
  tags = {
    ENV = var.env
  }
}
