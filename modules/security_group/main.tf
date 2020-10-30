resource "aws_security_group" "sg_web_load_balancer" {
  vpc_id = var.vpc_id
  tags = {
    name = "sg-web-load_balancer"
  }
}

resource "aws_security_group_rule" "sg_rule_web_load_balancer" {
  type = "ingress"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.sg_web_load_balancer.id
}

resource "aws_security_group" "sg_web_instance" {
  vpc_id = var.vpc_id
  tags = {
    name = "sg-web-instance"
  }
}

resource "aws_security_group_rule" "sg_rule_instance_web" {
  type = "ingress"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  source_security_group_id = aws_security_group.sg_web_load_balancer.id
  security_group_id = aws_security_group.sg_web_instance.id
}

output "web_load_balancer_sg_id" {
  description = "security group id for loadbalancer"
  value = aws_security_group.sg_web_load_balancer.id
}

output "web_instance_sg_id" {
  description = "security group id for instances"
  value = aws_security_group.sg_web_instance.id
}