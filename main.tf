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

module "compute" {
  source = "./modules/compute"
  subnet_web_ids = module.network.subnet_web_ids
  security_group_id = module.security_group.security_group_id
}