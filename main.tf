# Configure the AWS Provider
terraform {
  required_version = ">=0.12"
}

provider "aws" {
  region     = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

resource "aws_vpc" "terraform" {
  cidr_block = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "terraform"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "terraform_igw" {
  vpc_id = aws_vpc.terraform.id
}

# Route table: attach Internet Gateway
resource "aws_route_table" "terraform_public_rt" {
  vpc_id = aws_vpc.terraform.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.terraform_igw.id
  }

  tags = {
    Name = "publicRouteTable"
  }
}

# 2 subnets web
resource "aws_subnet" "terraform_subnet_web" {
  count = length(var.web_subnets)
  vpc_id = aws_vpc.terraform.id
  cidr_block = var.web_subnets[count.index].cidr
  availability_zone = var.web_subnets[count.index].az

  tags = {
    Name = format("%s%s","terraform-subnet_web_",count.index + 1)
  }
}

# Route table association with public subnets
resource "aws_route_table_association" "association_with_subnets_web" {
  count = length(aws_subnet.terraform_subnet_web)
  subnet_id      = element(aws_subnet.terraform_subnet_web.*.id,count.index)
  route_table_id = aws_route_table.terraform_public_rt.id
}

# 2 subnets rds
resource "aws_subnet" "terraform_subnet_rds" {
  count = length(var.rds_subnets)
  vpc_id = aws_vpc.terraform.id
  cidr_block = var.rds_subnets[count.index].cidr
  availability_zone = var.rds_subnets[count.index].az

  tags = {
    Name = format("%s%s","terraform-subnet_rds_",count.index + 1)
  }
}

resource "aws_security_group" "sg-web-instance" {
  vpc_id      = aws_vpc.terraform.id
  tags = {
    "type" = "terraform-sg-web-instances"
    Name = "terraform-sg-web-instance"
  }
}

resource "aws_instance" "web-instance" {
  count = length(aws_subnet.terraform_subnet_web)
  ami = "ami-00a205cb8e06c3c4e"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.terraform_subnet_web[count.index].id
  security_groups = [aws_security_group.sg-web-instance.id]

  tags = {
    Name = format("%s%s","terraform-ec2_web_",count.index + 1)
  }
}

