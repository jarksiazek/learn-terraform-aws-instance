resource "aws_security_group" "sg_web_load_balancer" {
  name = var.load_balancer_name
  vpc_id = var.vpc_id
  tags = {
    name = var.load_balancer_name
    env = var.aws_env
  }

  dynamic ingress {
    iterator = rule
    for_each = var.ingress_traffic_load_balancer
    content {
      description = rule.value.description
      from_port = rule.value.from_port
      to_port = rule.value.to_port
      protocol = rule.value.protocol
      cidr_blocks = rule.value.cidr_blocks
    }
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
  name = var.ec2_name
  vpc_id = var.vpc_id
  tags = {
    name = var.ec2_name
  }

  dynamic ingress {
    iterator = rule
    for_each = var.ingress_traffic_ec2
    content {
      description = rule.value.description
      from_port = rule.value.from_port
      to_port = rule.value.to_port
      protocol = rule.value.protocol
      security_groups = [aws_security_group.sg_web_load_balancer.id]
    }
  }

  egress {
    description = var.egress_all_traffic.description
    from_port   = var.egress_all_traffic.from_port
    to_port     = var.egress_all_traffic.to_port
    protocol    = var.egress_all_traffic.protocol
    cidr_blocks = var.egress_all_traffic.cidr_blocks
  }
}

resource "aws_security_group" "sg_db_instance" {
  name = var.db_name
  vpc_id = var.vpc_id
  tags = {
    name = "sg-db-instance"
  }

  dynamic ingress {
    iterator = rule
    for_each = var.ingress_traffic_db
    content {
      description = rule.value.description
      from_port = rule.value.from_port
      to_port = rule.value.to_port
      protocol = rule.value.protocol
      security_groups = [aws_security_group.sg_web_instance.id]
    }
  }

  egress {
    description = var.egress_all_traffic.description
    from_port   = var.egress_all_traffic.from_port
    to_port     = var.egress_all_traffic.to_port
    protocol    = var.egress_all_traffic.protocol
    cidr_blocks = var.egress_all_traffic.cidr_blocks
  }
}