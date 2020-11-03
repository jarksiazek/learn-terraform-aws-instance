variable "vpc_id" {
  description = "The vpc ID from the network module"
  type = string
}

variable "ingress_traffic" {
  description = "ingress traffic"
  type = map(object({
    description = string
    from_port = number
    to_port = number
    protocol = string
    cidr_blocks = list(string)
  }))
  default = {
    ec2 = {
      description = "Ingress ec2 to alb"
      from_port = 80
      to_port = 80
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    },
    load_balancer = {
      description = "Ingress alb from internet"
      from_port = 80
      to_port = 80
      protocol = "tcp"
      cidr_blocks = []
    },
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
    cidr_blocks = [
      "0.0.0.0/0"]
  }
}