variable "subnet_web_ids" {
  description = "The subnet web ids from the network module"
  type = list(string)
}

variable "security_group_id" {
  description = "The security group id applied to network"
  type = string
}