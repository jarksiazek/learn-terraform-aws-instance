resource "aws_security_group" "this" {
  name = var.sg_name
  vpc_id = var.vpc_id
  tags = {
    name = var.sg_name
    env = var.aws_env
  }

  dynamic ingress {
    iterator = rule
    for_each = var.ingress_traffic
    content {
      description = rule.value.description
      from_port = rule.value.from_port
      to_port = rule.value.to_port
      protocol = rule.value.protocol
      cidr_blocks = rule.value.cidr_blocks
      security_groups = rule.value.security_groups
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
