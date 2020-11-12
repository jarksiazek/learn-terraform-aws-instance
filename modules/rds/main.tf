resource "random_password" "this" {
  length = 16
  special = true
  override_special = "_%@"
}

resource "aws_db_subnet_group" "this" {
  name = "db-subnet-group"
  description = "DB subnet group"
  subnet_ids = var.db_subnet_ids
}

resource "aws_db_instance" "this" {

  identifier = "db-terraform"

  engine = var.db_engine
  engine_version = var.db_engine_version
  instance_class = var.db_instance_class
  availability_zone = var.db_availability_zone
  storage_type = var.db_storage_type
  allocated_storage = var.db_allocated_storage

  username = var.db_user
  password = random_password.this.result
  port     = var.db_port

  db_subnet_group_name = aws_db_subnet_group.this.name
  vpc_security_group_ids = [var.db_sg_id]

  maintenance_window = var.db_maintenance_window
  backup_window      = var.db_backup_window

  skip_final_snapshot = true
  deletion_protection = false

  lifecycle {
    ignore_changes = ["password"]
  }

  tags = {
    env = var.aws_env
  }
}