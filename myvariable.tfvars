aws_environment = "dev"
aws_region = "eu-central-1"
ec2_instance = {
  aws_web_azs = ["eu-central-1a", "eu-central-1b"],
  ami_name = "amzn2-ami-hvm-*",
  instance_type = "t2.micro"
}
rds_instance = {
  aws_rds_azs = ["eu-central-1a", "eu-central-1b"],
  engine = "mysql",
  engine_version = "8.0.20",
  instance_class = "db.t2.micro",
  availability_zone = "eu-central-1a",
  storage_type = "gp2",
  allocated_storage = 20,
  maintenance_window = "Mon:00:00-Mon:03:00"
  backup_window      = "03:00-06:00"
}