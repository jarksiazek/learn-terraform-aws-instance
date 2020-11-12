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

variable "ingress_traffic" {
  description = "ingress traffic"
  type = list(object({
    description = string
    from_port = number
    to_port = number
    protocol = string
    cidr_blocks = list(string)
    security_groups = list(string)
  }))
}

variable "sg_name" {
  description = "Name of security group"
  type = string
}

variable "vpc_id" {
  description = "The vpc ID from the network module"
  type = string
}

variable "aws_env" {
  type = string
}