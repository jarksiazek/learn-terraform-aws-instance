resource "aws_lb_target_group" "target_group" {
  name     = "tg"
  target_type = "instance"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
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

resource "aws_lb_target_group_attachment" "target_group_attach_web_instances" {
  count            = length(var.instance_ids)
  target_group_arn = aws_lb_target_group.target_group.arn
  target_id        = element(var.instance_ids, count.index)
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
    target_group_arn = aws_lb_target_group.target_group.arn
  }
}