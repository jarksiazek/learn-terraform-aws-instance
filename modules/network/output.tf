output "vpc_id" {
  description = "vpc id"
  value = aws_vpc.this.id
}

output "subnet_web_ids" {
  description = "subnet ids for web servers"
  value = aws_subnet.web.*.id
}

output "subnet_db_ids" {
  description = "subnet ids for db"
  value = aws_subnet.rds.*.id
}