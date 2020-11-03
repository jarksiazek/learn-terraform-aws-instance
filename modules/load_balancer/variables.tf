variable "vpc_id" {
  description = "The vpc ID from the network module"
  type = string
}

variable "subnet_web_ids" {
  description = "The subnet web ids from the network module"
  type = list(string)
}

variable "target_names" {
  type = list(string)
  default = ["tgWebInstanceTargetOne", "tgWebInstanceTargetTwo"]
}

variable "sg_load_balancer_id" {
  description = "The security group id for load balancer"
  type = string
}

variable "tg_default_values" {
  description = "default values for all target groups"
  type = object({
    target_type = string
    port = number
    protocol = string
  })
  default = {
    target_type = "instance"
    port     = 80
    protocol = "HTTP"
  }
}

variable "target_groups" {
  description = "Target groups"
  type = map(object({
    name = string
  }))
  default = {
    tg-default = {
      name = "tg-default"
    },
    tg-target1 = {
      name = "tg-target1"
    },
  }
}

variable "default_health_check" {
  description = "Default health check"
  type = object({
    protocol            = string
    path                = string
    healthy_threshold   = number
    unhealthy_threshold = number
    timeout             = number
    interval            = number
    matcher             = string
  })
  default = {
    protocol = "HTTP"
    path = "/"
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 5
    interval = 10
    matcher = "200"
  }
}
