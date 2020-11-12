variable "vpc_cidr" {
  type = string
  default = "10.0.0.0/16"
}

variable "rt_route_cidr" {
  type = string
  default = "0.0.0.0/0"
}

variable "aws_env" {
  type = string
}

variable "aws_web_subnet_azs" {
  type = list(string)
}

variable "aws_rds_subnet_azs" {
  type = list(string)
}