data "aws_ami" "amazon-linux-2" {
  most_recent = true
  owners = ["amazon"]
  filter {
    name = "name"
    values = [var.instance_parameters.ami_name]
  }
  filter {
    name = "architecture"
    values = ["x86_64"]
  }
}

resource "aws_launch_template" "this" {
  name = "asg-template-default"
  description = "Asg Template"
  image_id = data.aws_ami.amazon-linux-2.image_id
  instance_type = var.instance_parameters.instance_type
  vpc_security_group_ids = [var.security_group_id]

  user_data = filebase64("${path.module}/example.sh")
}

resource "aws_autoscaling_group" "this" {
  name = "asg-template-default"
  vpc_zone_identifier = var.subnet_web_ids
  target_group_arns = var.target_group_arns

  max_size                  = 2
  min_size                  = 1
  desired_capacity          = 1

  launch_template {
    id = aws_launch_template.this.id
    version = "$Latest"
  }
}

resource "aws_autoscaling_schedule" "this" {
  for_each = var.asg_schedules
  scheduled_action_name  = each.value.name
  autoscaling_group_name = aws_autoscaling_group.this.name
  min_size               = each.value.min_size
  max_size               = each.value.max_size
  desired_capacity       = each.value.desired_capacity
  recurrence = each.value.recurrence
}

resource "aws_autoscaling_policy" "this" {
  name = "terraform-test"
  autoscaling_group_name = aws_autoscaling_group.this.name
  cooldown = 300
  scaling_adjustment = 1
  adjustment_type = "ChangeInCapacity"
}