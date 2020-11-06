variable "load_balancer_name" {
  description = "Name of load balancer security group"
  type = string
  default = "sg-web-load-balancer"
}

variable "ec2_name" {
  description = "Name of ec2 security group"
  type = string
  default = "sg-web-instance"
}

variable "db_name" {
  description = "Name of db security group"
  type = string
  default = "sg-db-instance"
}

variable "ingress_traffic_ec2" {
  description = "ingress traffic"
  type = map(object({
    description = string
    from_port = number
    to_port = number
    protocol = string
    cidr_blocks = list(string)
  }))
  default = {
    group1 = {
      description = "Ingress ec2 to alb"
      from_port = 80
      to_port = 80
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}

variable "ingress_traffic_load_balancer" {
  description = "ingress traffic"
  type = map(object({
    description = string
    from_port = number
    to_port = number
    protocol = string
    cidr_blocks = list(string)
  }))
  default = {
    group1 = {
      description = "Ingress alb from internet"
      from_port = 80
      to_port = 80
      protocol = "tcp"
      cidr_blocks = []
    }
  }
}

variable "ingress_traffic_db" {
  description = "ingress traffic"
  type = map(object({
    description = string
    from_port = number
    to_port = number
    protocol = string
    cidr_blocks = list(string)
  }))
  default = {
    group1 = {
      description = "Ingress db from instance"
      from_port = 3306
      to_port = 3306
      protocol = "tcp"
      cidr_blocks = []
    }
  }
}

variable "egress_all_traffic" {
  description = "Egress all traffic"
  type = object({
    description = string
    from_port = number
    to_port = number
    protocol = string
    cidr_blocks = list(string)
  })
  default = {
    description = "All traffic"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

variable "vpc_id" {
  description = "The vpc ID from the network module"
  type = string
}

variable "aws_env" {
  type = string
}