data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners = ["amazon"]
  filter {
    name = "name"
    values = [var.ec2_instance_aim_name]
  }
  filter {
    name = "architecture"
    values = ["x86_64"]
  }
}

resource "aws_launch_template" "this" {
  name = "asg-template-default"
  description = "Asg Template"
  image_id = data.aws_ami.amazon_linux_2.image_id
  instance_type = var.ec2_instance_type
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

# scale up alarm
resource "aws_autoscaling_policy" "cpu_policy_scaleup" {
  name = "cpu-policy-scaleup"
  autoscaling_group_name = aws_autoscaling_group.this.name
  cooldown = 300
  scaling_adjustment = 1
  adjustment_type = "ChangeInCapacity"
}

resource "aws_cloudwatch_metric_alarm" "cpu_alarm_scaleup" {
  alarm_name = "cpu-alarm-scaleup"
  alarm_description = "cpu-alarm-scaleup"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods = "2"
  metric_name = "CPUUtilization"
  namespace = "AWS/EC2"
  period = "120"
  statistic = "Average"
  threshold = "30"
  dimensions = {
    "AutoScalingGroupName" = aws_autoscaling_group.this.name
  }
  actions_enabled = true
  alarm_actions = [aws_autoscaling_policy.cpu_policy_scaleup.arn]
}

# scale down alarm
resource "aws_autoscaling_policy" "cpu_policy_scaledown" {
  name = "cpu-policy-scaledown"
  autoscaling_group_name = aws_autoscaling_group.this.name
  adjustment_type = "ChangeInCapacity"
  scaling_adjustment = "-1"
  cooldown = "300"
  policy_type = "SimpleScaling"
}

resource "aws_cloudwatch_metric_alarm" "example_cpu_alarm_scaledown" {
  alarm_name = "cpu-alarm-scaledown"
  alarm_description = "cpu-alarm-scaledown"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods = "2"
  metric_name = "CPUUtilization"
  namespace = "AWS/EC2"
  period = "120"
  statistic = "Average"
  threshold = "5"
  dimensions = {
    "AutoScalingGroupName" = aws_autoscaling_group.this.name
  }
  actions_enabled = true
  alarm_actions = [aws_autoscaling_policy.cpu_policy_scaledown.arn]
}