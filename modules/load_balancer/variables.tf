variable "vpc_id" {
  description = "The vpc ID from the network module"
  type = string
}

variable "subnet_web_ids" {
  description = "The subnet web ids from the network module"
  type = list(string)
}

variable "instance_ids" {
  description = "The instance ids to be attached to load balancer"
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

