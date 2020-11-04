resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    env = var.aws_env
  }
}

# Internet Gateway
resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = {
    env = var.aws_env
  }
}

# Route table: attach Internet Gateway
resource "aws_route_table" "this" {
  vpc_id = aws_vpc.this.id
  route {
    cidr_block = var.rt_route_cidr
    gateway_id = aws_internet_gateway.this.id
  }

  tags = {
    env = var.aws_env
  }
}

resource "aws_subnet" "web" {
  count = length(var.aws_web_subnet_azs)
  vpc_id = aws_vpc.this.id
  cidr_block = cidrsubnet(var.vpc_cidr, 8, count.index + 1)
  availability_zone = var.aws_web_subnet_azs[count.index]
  map_public_ip_on_launch = true

  tags = {
    name = format("%s%s", "subnet_web_", element(var.aws_web_subnet_azs, count.index))
    env = var.aws_env
  }
}

resource "aws_subnet" "rds" {
  count = length(var.aws_rds_subnet_azs)
  vpc_id = aws_vpc.this.id
  cidr_block = cidrsubnet(var.vpc_cidr, 8, count.index + 11)
  availability_zone = var.aws_rds_subnet_azs[count.index]

  tags = {
    name = format("%s%s", "subnet_rds_", element(var.aws_rds_subnet_azs, count.index))
    env = var.aws_env
  }
}

resource "aws_route_table_association" "web" {
  count = length(aws_subnet.web)
  subnet_id = aws_subnet.web[count.index].id
  route_table_id = aws_route_table.this.id
}