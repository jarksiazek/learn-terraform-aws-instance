output "vpc_id" {
  description = "vpc id"
  value = aws_vpc.this.id
}

output "subnet_web_ids" {
  description = "subnet ids"
  value = aws_subnet.web.*.id
}