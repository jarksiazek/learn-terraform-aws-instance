resource "aws_security_group" "sg_web_load_balancer" {
  name = "sgWebLoadBalancer"
  vpc_id = var.vpc_id
  tags = {
    name = "sg-web-load_balancer"
  }

  ingress {
    description = var.ingress_traffic.ec2.description
    from_port   = var.ingress_traffic.ec2.from_port
    to_port     = var.ingress_traffic.ec2.to_port
    protocol    = var.ingress_traffic.ec2.protocol
    cidr_blocks = var.ingress_traffic.ec2.cidr_blocks
  }

  egress {
    description = var.egress_all_traffic.description
    from_port   = var.egress_all_traffic.from_port
    to_port     = var.egress_all_traffic.to_port
    protocol    = var.egress_all_traffic.protocol
    cidr_blocks = var.egress_all_traffic.cidr_blocks
  }
}

resource "aws_security_group" "sg_web_instance" {
  name = "sgWebInstance"
  vpc_id = var.vpc_id
  tags = {
    name = "sg-web-instance"
  }

  ingress {
    description = var.ingress_traffic.load_balancer.description
    from_port   = var.ingress_traffic.load_balancer.from_port
    to_port     = var.ingress_traffic.load_balancer.to_port
    protocol    = var.ingress_traffic.load_balancer.protocol
    security_groups = [aws_security_group.sg_web_load_balancer.id]
  }

  egress {
    description = var.egress_all_traffic.description
    from_port   = var.egress_all_traffic.from_port
    to_port     = var.egress_all_traffic.to_port
    protocol    = var.egress_all_traffic.protocol
    cidr_blocks = var.egress_all_traffic.cidr_blocks
  }
}