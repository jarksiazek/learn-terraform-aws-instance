data "aws_ami" "amazon-linux-2" {
  most_recent = true
  owners = ["amazon"]
  filter {
    name = "name"
    values = [var.instance.ami_name]
  }
  filter {
    name = "architecture"
    values = ["x86_64"]
  }
}

resource "aws_launch_template" "asg_template_default" {
  name = "asg-template-default"
  description = "Asg Template"
  image_id = data.aws_ami.amazon-linux-2.image_id
  instance_type = var.instance.instance_type
  vpc_security_group_ids = [var.security_group_id]

  user_data = filebase64("${path.module}/example.sh")
}

resource "aws_autoscaling_group" "asg_template_default" {
  name = "asg-template-default"
  vpc_zone_identifier = var.subnet_web_ids
  target_group_arns = var.target_group_arns

  max_size                  = 2
  min_size                  = 2
  desired_capacity          = 2

  launch_template {
    id = aws_launch_template.asg_template_default.id
    version = "$Latest"
  }
}