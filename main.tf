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
  aws_web_subnet_azs = var.aws_web_azs
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
  instance = var.instance
}
