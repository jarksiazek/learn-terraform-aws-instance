output "web_load_balancer_sg_id" {
  description = "security group id for loadbalancer"
  value = aws_security_group.sg_web_load_balancer .id
}

output "web_instance_sg_id" {
  description = "security group id for instances"
  value = aws_security_group.sg_web_instance.id
}