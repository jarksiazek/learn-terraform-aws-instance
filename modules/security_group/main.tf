resource "aws_security_group" "sg_web_load_balancer" {
  name = "sgWebLoadBalancer"
  vpc_id = var.vpc_id
  tags = {
    name = "sg-web-load_balancer"
  }

  ingress {
    description = "Internet to ALB"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "All traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "sg_web_instance" {
  name = "sgWebInstance"
  vpc_id = var.vpc_id
  tags = {
    name = "sg-web-instance"
  }

  egress {
    description = "All traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group_rule" "sg_rule_instance_web" {
  description = "ALB to instance"
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