variable "db_engine" {
  type = string
  description = "db engine"
  default = "mysql"
}

variable "db_user" {
  type = string
  description = "db user"
  default = "frankfurt"
}

variable "db_port" {
  type = string
  description = "db port"
  default = "3306"
}

variable "db_engine_version" {
  type = string
  description = "db engine version"
  default = "8.0.20"
}

variable "db_storage_type" {
  type = string
  description = "db storage type"
  default = "gp2"
}

variable "db_maintenance_window" {
  type = string
  description = "db maintenance window"
  default = "Mon:00:00-Mon:03:00"
}

variable "db_backup_window" {
  type = string
  description = "db backup window"
  default = "03:00-06:00"
}

variable "aws_env" {
  type = string
}

variable "db_subnet_ids" {
  description = "List of subnet for db"
  type = list(string)
}

variable "db_sg_id" {
  description = "security group id for db"
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