variable "aws_env" {
  type = string
}

variable "subnet_ids" {
  description = "List of subnet for db"
  type = list(string)
}

variable "sg_db_id" {
  description = "security group id for db"
  type = string
}

variable "rds_parameters" {
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
  description = "rds_parameters"
}