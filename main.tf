terraform {
  required_version = "= 0.13.5"
  backend "s3" {
    bucket = "terraform-eu-central-2020"
    key = "my"
    region = "eu-central-1"
  }
}

provider "aws" {
  region = var.aws_region
  shared_credentials_file = "%USERPROFILE%/.aws/credentials"
  profile                 = "terraform"
}

module "network" {
  source = "./modules/network"
  aws_env = var.aws_environment
  aws_web_subnet_azs = var.ec2_instance.aws_web_azs
  aws_rds_subnet_azs = var.rds_instance.aws_rds_azs
}

module "security_group" {
  source = "./modules/security_group"
  vpc_id = module.network.vpc_id
}

module "load_balancer" {
  source = "./modules/load_balancer"
  vpc_id = module.network.vpc_id
  subnet_web_ids = module.network.subnet_web_ids
  sg_load_balancer_id = module.security_group.web_load_balancer_sg_id
}

module "auto_scaling_group" {
  source = "./modules/auto_scaling_group"
  security_group_id = module.security_group.web_instance_sg_id
  subnet_web_ids = module.network.subnet_web_ids
  target_group_arns = module.load_balancer.target_group_arns
  instance_parameters = var.ec2_instance
}

module "rds_mysql" {
  source = "./modules/rds"
  aws_env = var.aws_environment
  subnet_ids = module.network.subnet_db_ids
  sg_db_id = module.security_group.db_instance_sg_id
  rds_parameters = var.rds_instance
}
