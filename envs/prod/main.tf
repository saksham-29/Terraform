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

  env    = var.env
  vpc_id = module.vpc.vpc_id
}

module "alb" {
  source = "../../modules/alb"

  env               = var.env
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  alb_sg_id         = module.security.alb_sg_id
  domain_name       = var.domain_name
  hosted_zone_name  = var.hosted_zone_name
}

module "compute" {
  source = "../../modules/compute"

  env                  = var.env
  ami_id               = var.ami_id
  instance_type        = var.instance_type
  private_subnet_ids   = module.vpc.private_subnet_ids
  app_sg_id            = module.security.app_sg_id
  target_group_arn     = module.alb.target_group_arn
  asg_max_size         = var.asg_max_size
  asg_min_size         = var.asg_min_size
  asg_desired_capacity = var.asg_desired_capacity
}

module "rds" {
  source = "../../modules/rds"

  env               = var.env
  db_name           = var.db_name
  db_username       = var.db_username
  db_password       = var.db_password
  db_instance_class = var.db_instance_class

  db_subnet_ids = module.vpc.private_db_subnet_ids
  db_sg_ids     = module.security.db_sg_ids
}
