variable "aws_environment" {
  type = string
  description = "AWS environment"
}

variable "aws_region" {
  type = string
  description = "AWS region"
}

variable "aws_web_azs" {
  type = list(string)
  description = "List of AZ's for web instances"
}

variable "instance" {
  type = object({
    ami_name = string
    instance_type = string
  })
  description = "Instance"
}