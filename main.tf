terraform {
  required_version = "= 0.13.5"
  backend "s3" {
    region = "eu-central-1"
  }
}

provider "aws" {
  region = var.aws_region
  profile = "up-skill-jk"
}

module "network" {
  source = "./modules/network"
  aws_env = var.aws_environment
  aws_web_subnet_azs = var.ec2_instance_azs
  aws_rds_subnet_azs = var.db_instance_azs
}

module "security_group_load_balancer" {
  source = "./modules/security_group"
  vpc_id = module.network.vpc_id
  aws_env = var.aws_environment
  sg_name = "sg_load_balancer"
  ingress_traffic = [
    {
      description = "Ingress alb from internet"
      from_port = 80
      to_port = 80
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      security_groups = []
    }
  ]
}

module "security_group_web" {
  source = "./modules/security_group"
  vpc_id = module.network.vpc_id
  aws_env = var.aws_environment
  sg_name = "sg_web"
  ingress_traffic = [
    {
      description = "Ingress ec2 to alb"
      from_port = 80
      to_port = 80
      protocol = "tcp"
      cidr_blocks = []
      security_groups = [module.security_group_load_balancer.sg_id]
    }
  ]
}

module "security_group_db" {
  source = "./modules/security_group"
  vpc_id = module.network.vpc_id
  aws_env = var.aws_environment
  sg_name = "sg_db"
  ingress_traffic = [
    {
      description = "Ingress db from instance"
      from_port = 3306
      to_port = 3306
      protocol = "tcp"
      cidr_blocks = []
      security_groups = [module.security_group_web.sg_id]
    }
  ]
}

module "load_balancer" {
  source = "./modules/load_balancer"
  vpc_id = module.network.vpc_id
  subnet_web_ids = module.network.subnet_web_ids
  sg_load_balancer_id = module.security_group_load_balancer.sg_id
}

module "auto_scaling_group" {
  source = "./modules/auto_scaling_group"
  security_group_id = module.security_group_web.sg_id
  subnet_web_ids = module.network.subnet_web_ids
  target_group_arns = module.load_balancer.target_group_arns
  ec2_instance_azs = var.ec2_instance_azs
  ec2_instance_aim_name = var.ec2_instance_aim_name
  ec2_instance_type = var.ec2_instance_type
}

module "rds_mysql" {
  source = "./modules/rds"
  aws_env = var.aws_environment
  db_subnet_ids = module.network.subnet_db_ids
  db_sg_id = module.security_group_db.sg_id
  db_instance_azs = var.db_instance_azs
  db_instance_class = var.db_instance_class
  db_availability_zone = var.db_availability_zone
  db_allocated_storage = var.db_allocated_storage
}

output "db_password" {
  value = module.rds_mysql.password
}
