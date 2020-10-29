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
