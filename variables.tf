variable "aws_environment" {
  type = string
  description = "AWS environment"
}

variable "aws_region" {
  type = string
  description = "AWS region"
}

variable "ec2_instance_azs" {
  description = "EC2 available zones"
  type = list(string)
}

variable "ec2_instance_aim_name" {
  description = "EC2 aim name"
  type = string
}

variable "ec2_instance_type" {
  description = "EC2 instance type"
  type = string
}

variable "db_instance_azs" {
  description = "DB available zones"
  type = list(string)
}

variable "db_instance_class" {
  description = "DB instance class"
  type = string
}

variable "db_availability_zone" {
  description = "DB Availability Zone"
  type = string
}

variable "db_allocated_storage" {
  description = "DB Allocated Storage"
  type = number
}