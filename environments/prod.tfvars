aws_environment = "prod"
aws_region = "eu-west-1"
aws_web_azs = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
aws_rds_azs = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
instance = {
  ami_name = "amzn2-ami-hvm-*",
  instance_type = "t2.micro"
}