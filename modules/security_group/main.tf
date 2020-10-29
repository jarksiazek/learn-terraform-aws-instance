resource "aws_security_group" "sg-web-instance" {
  vpc_id = var.vpc_id
  tags = {
    "type" = "terraform-sg-web-instances"
    Name = "terraform-sg-web-instance"
  }
}

resource "aws_security_group_rule" "sg_rule_SSH" {
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.sg-web-instance.id
}

resource "aws_security_group_rule" "sg_rule_apache" {
  type = "ingress"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.sg-web-instance.id
}

output "security_group_id" {
  description = "security group id"
  value = aws_security_group.sg-web-instance.id
}