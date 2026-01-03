module "vpc" {
  source = "../../modules/vpc"

  env                     = var.env
  vpc_cidr                = var.vpc_cidr
  azs                     = var.azs
  public_subnet_cidrs     = var.public_subnet_cidrs
  private_subnet_cidrs    = var.private_subnet_cidrs
  private_db_subnet_cidrs = var.private_db_subnet_cidrs
}

module "security" {
  source = "../../modules/security"

  env   = var.env
  vpc_id = module.vpc.vpc_id
}