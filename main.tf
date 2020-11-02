terraform {
  required_version = ">=0.12"
  backend "s3" {
    bucket = "terraform-eu-central-2020"
    key = "my"
    region = "eu-central-1"
  }
}

provider "aws" {
  region = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

module "network" {
  source = "./modules/network"
}

module "security_group" {
  source = "./modules/security_group"
  vpc_id = module.network.vpc_id
}

/*module "compute" {
  source = "./modules/compute"
  subnet_web_ids = module.network.subnet_web_ids
  security_group_id = module.security_group.web_instance_sg_id
}*/

module "load_balancer" {
  source = "./modules/load_balancer"
  vpc_id = module.network.vpc_id
  subnet_web_ids = module.network.subnet_web_ids
  sg_load_balancer_id = module.security_group.web_load_balancer_sg_id
  //instance_ids = module.compute.instance_ids
}

module "auto_scaling_group" {
  source = "./modules/auto_scaling_group"
  security_group_id = module.security_group.web_instance_sg_id
  subnet_web_ids = module.network.subnet_web_ids
  target_group_arns = module.load_balancer.target_group_arns
}
