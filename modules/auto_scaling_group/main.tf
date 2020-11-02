resource "aws_launch_template" "asg_template_default" {
  name = "asg-template-default"
  description = "Asg Template"
  image_id = "ami-00a205cb8e06c3c4e"
  instance_type = "t2.micro"
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