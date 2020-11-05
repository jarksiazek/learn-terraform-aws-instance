resource "aws_db_subnet_group" "this" {
  name = "db-subnet-group"
  description = "DB subnet group"
  subnet_ids = var.subnet_ids
}

resource "aws_db_instance" "this" {

  identifier = "db-terraform"

  engine = var.rds_parameters.engine
  engine_version = "8.0.20"
  instance_class = var.rds_parameters.instance_class
  availability_zone = var.rds_parameters.availability_zone
  storage_type = var.rds_parameters.storage_type
  allocated_storage = var.rds_parameters.allocated_storage

  username = "frankfurt"
  password = "frankfurt"
  port     = "3306"

  db_subnet_group_name = aws_db_subnet_group.this.name
  vpc_security_group_ids = [var.sg_db_id]

  maintenance_window = var.rds_parameters.maintenance_window
  backup_window      = var.rds_parameters.backup_window

  //final_snapshot_identifier = "db-terraform-snapshot"
  skip_final_snapshot = true
  deletion_protection = false

  tags = {
    env = var.aws_env
  }
}