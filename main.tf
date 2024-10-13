provider "aws" {
  region = var.region
}

module "vpc" {
  source               = "./modules/Vpc"
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones   = var.availability_zones
}

module "route_tables" {
  source              = "./modules/Route_Tables"
  vpc_id              = module.vpc.vpc_id
  public_subnet_ids   = module.vpc.public_subnet_ids
  private_subnet_ids  = module.vpc.private_subnet_ids
  internet_gateway_id = module.vpc.internet_gateway_id
  nat_gateway_ids     = module.nat_gateway.nat_gateway_ids
}


module "nat_gateway" {
  source            = "./modules/nat_gateway"
  public_subnet_ids = module.vpc.public_subnet_ids
}