variable "aws_environment" {
  type = string
  description = "AWS environment"
}

variable "aws_region" {
  type = string
  description = "AWS region"
}

variable "ec2_instance" {
  type = object({
    aws_web_azs = list(string)
    ami_name = string
    instance_type = string
  })
  description = "Instance"
}

variable "rds_instance" {
  type = object({
    aws_rds_azs = list(string)
    engine = string
    engine_version = string
    instance_class = string
    availability_zone = string
    storage_type = string
    allocated_storage = number,
    maintenance_window = string
    backup_window = string
  })
  description = "rds_instance"
}