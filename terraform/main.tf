provider "aws" {
  region = var.region
}

module "VPC" {
  source               = "./modules/VPC"
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones   = var.availability_zones
}

module "Route_Tables" {
  source              = "./modules/Route_Tables"
  vpc_id              = module.VPC.vpc_id
  public_subnet_ids   = module.VPC.public_subnet_ids
  private_subnet_ids  = module.VPC.private_subnet_ids
  internet_gateway_id = module.VPC.internet_gateway_id
  nat_gateway_ids     = module.Nat_Gateway.nat_gateway_ids
}


module "Nat_Gateway" {
  source            = "./modules/Nat_Gateway"
  public_subnet_ids = module.VPC.public_subnet_ids
}

module "ec2" {
  source                 = "./modules/ec2"
  ami_id                 = var.ami_id
  instance_type          = var.instance_type
  public_subnet_ids      = module.VPC.public_subnet_ids
  private_subnet_ids     = module.VPC.private_subnet_ids
  public_sg_id           = module.Security_Groups.public_sg_id
  private_sg_id          = module.Security_Groups.private_sg_id
  //key_name               = aws_key_pair.nhom15.key_name
  public_instance_count  = var.public_instance_count
  private_instance_count = var.private_instance_count
  key_name               = var.key_name
}

module "Security_Groups" {
  source = "./modules/Security_Group"
  vpc_id = module.VPC.vpc_id
  my_ip  = var.my_ip
}

# resource "aws_key_pair" "nhom15" {
#   key_name   = "Nhom15"
#   public_key = var.id_ed25519_pub
# }

module "keypair" {
  source             = "./modules/keypair"
  key_name           = var.key_name
  create_private_key = true
}

resource "local_file" "private_key" {
  content         = module.keypair.private_key_pem
  filename        = "${path.module}/${var.key_name}.pem"
  file_permission = "0600"
}
