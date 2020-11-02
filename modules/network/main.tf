resource "aws_vpc" "terraform" {
  cidr_block = var.vpc_cidr
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    name = "terraform"
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
    name = "publicRouteTable"
  }
}

resource "aws_subnet" "terraform_subnet_web" {
  count = length(var.web_subnets)
  vpc_id = aws_vpc.terraform.id
  cidr_block = var.web_subnets[count.index].cidr
  availability_zone = var.web_subnets[count.index].az
  map_public_ip_on_launch = true

  tags = {
    name = format("%s%s", "terraform-subnet_web_", count.index + 1)
  }
}

resource "aws_route_table_association" "association_with_subnets_web" {
  count = length(aws_subnet.terraform_subnet_web)
  subnet_id = element(aws_subnet.terraform_subnet_web.*.id, count.index)
  route_table_id = aws_route_table.terraform_public_rt.id
}

output "vpc_id" {
  description = "vpc id"
  value = aws_vpc.terraform.id
}

output "subnet_web_ids" {
  description = "subnet ids"
  value = aws_subnet.terraform_subnet_web.*.id
}