resource "aws_lb_target_group" "target_group_default" {
  name     = "tg-default"
  target_type = "instance"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  lifecycle {
    create_before_destroy = true
  }
  health_check {
    protocol            = "HTTP"
    path                = "/"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 10
    matcher             = "200"
  }
}

resource "aws_lb_target_group" "target_group_target1" {
  name     = "tg-target1"
  target_type = "instance"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  lifecycle {
    create_before_destroy = true
  }
  health_check {
    protocol            = "HTTP"
    path                = "/"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 10
    matcher             = "200"
  }
}

resource "aws_lb_target_group_attachment" "target_group_default_attach_web_instances" {
  target_group_arn = aws_lb_target_group.target_group_default.arn
  target_id        = var.instance_ids[0]
  port             = 80
}

resource "aws_lb_target_group_attachment" "target_group_target1_attach_web_instances" {
  target_group_arn = aws_lb_target_group.target_group_target1.arn
  target_id        = var.instance_ids[1]
  port             = 80
}

resource "aws_lb" "web_alb" {
  name               = "web-alb"
  load_balancer_type = "application"
  security_groups    = [var.sg_load_balancer_id]
  subnets            = var.subnet_web_ids
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.web_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group_default.arn
  }
}

resource "aws_lb_listener_rule" "target_rule" {
  listener_arn  = aws_lb_listener.front_end.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group_target1.arn
  }
  condition {
    path_pattern {
      values = ["/target/*"]
    }
  }
}