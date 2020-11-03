aws_environment = "dev"
aws_region = "eu-central-1"
aws_web_azs = ["eu-central-1a", "eu-central-1b"]
aws_rds_azs = ["eu-central-1a", "eu-central-1b"]
instance = {
  ami_name = "amzn2-ami-hvm-*",
  instance_type = "t2.micro"
}