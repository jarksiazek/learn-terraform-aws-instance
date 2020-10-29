variable "aws_access_key" {
  type = string
  description = "AWS access key"
}
variable "aws_secret_key" {
  type = string
  description = "AWS secret key"
}
variable "aws_region" {
  type = string
  description = "AWS region"
  default = "eu-central-1"
}

variable "vpc_cidr" {
  type = string
  default = "10.0.0.0/16"
}

variable "web_subnets" {
  type = list(object({
    cidr = string
    az = string
  }))
  default = [
    {
      cidr = "10.0.1.0/24"
      az = "eu-central-1a"},
    {
      cidr = "10.0.2.0/24"
      az = "eu-central-1b"}
  ]
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
