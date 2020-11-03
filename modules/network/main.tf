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

resource "aws_subnet" "this" {
  for_each = var.web_subnets
  vpc_id = aws_vpc.this.id
  cidr_block = each.value.cidr
  availability_zone = each.value.az
  map_public_ip_on_launch = true

  tags = {
    name = format("%s%s", "subnet_web_", each.value.)
    env = var.aws_env
  }
}

resource "aws_route_table_association" "this" {
  for_each = aws_subnet.this
  subnet_id = each.value.id
  route_table_id = aws_route_table.this.id
}