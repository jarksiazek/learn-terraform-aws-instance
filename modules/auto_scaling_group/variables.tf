variable "subnet_web_ids" {
  description = "The subnet web ids from the network module"
  type = list(string)
}

variable "security_group_id" {
  description = "The security group id applied to network"
  type = string
}

variable "target_group_arns" {
  description = "The arns of target groups"
  type = list(string)
}

variable "instance_parameters" {
  type = object({
    aws_web_azs = list(string)
    ami_name = string
    instance_type = string
  })
  description = "Instance"
}

variable "asg_schedules" {
  type = map(object({
    name = string
    min_size = string
    max_size = string
    desired_capacity = string
    recurrence = string
  }))
  default = {
    "startup" = {
      name = "startup"
      min_size = "1",
      max_size = "2",
      desired_capacity = "1",
      recurrence = "0 6 * * MON-FRI"
    },
    "shutdown" = {
      name = "shutdown",
      min_size = "0",
      max_size = "0",
      desired_capacity = "0",
      recurrence = "0 18 * * MON-FRI"
    }
  }
}