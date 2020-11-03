resource "aws_lb_target_group" "this" {
  for_each = var.target_groups
  name     = each.value.name
  target_type = var.tg_default_values.target_type
  port     = var.tg_default_values.port
  protocol = var.tg_default_values.protocol
  vpc_id   = var.vpc_id
  health_check {
    protocol            = var.default_health_check.protocol
    path                = var.default_health_check.path
    healthy_threshold   = var.default_health_check.healthy_threshold
    unhealthy_threshold = var.default_health_check.unhealthy_threshold
    timeout             = var.default_health_check.timeout
    interval            = var.default_health_check.interval
    matcher             = var.default_health_check.matcher
  }

  tags = {
    key = each.key
  }
}

resource "aws_lb" "this" {
  name               = "web-alb"
  load_balancer_type = "application"
  security_groups    = [var.sg_load_balancer_id]
  subnets            = var.subnet_web_ids
}

resource "aws_lb_listener" "this" {
  load_balancer_arn = aws_lb.this.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = lookup(aws_lb_target_group.this, var.target_groups.tg-default.name).arn
  }
}

resource "aws_lb_listener_rule" "this" {
  listener_arn  = aws_lb_listener.this.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = lookup(aws_lb_target_group.this, var.target_groups.tg-target1.name).arn
  }
  condition {
    path_pattern {
      values = ["/target/*"]
    }
  }
}