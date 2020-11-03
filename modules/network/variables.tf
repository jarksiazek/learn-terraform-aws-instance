variable "aws_env" {
  type = string
}

variable "vpc_cidr" {
  type = string
  default = "10.0.0.0/16"
}

variable "rt_route_cidr" {
  type = string
  default = "0.0.0.0/0"
}

variable "web_subnets" {
  type = map(object({
    cidr = string
    az = string
  }))
  default = {
    sub1 = {
      cidr = "10.0.1.0/24"
      az = "eu-central-1a"
    },
    sub2 = {
      cidr = "10.0.2.0/24"
      az = "eu-central-1b"
    }
  }
}

variable "rds_subnets" {
  type = list(object({
    cidr = string
    az = string
  }))
  default = [
    {
      cidr = "10.0.3.0/24"
      az = "eu-central-1a"},
    {
      cidr = "10.0.4.0/24"
      az = "eu-central-1b"}
  ]
}
