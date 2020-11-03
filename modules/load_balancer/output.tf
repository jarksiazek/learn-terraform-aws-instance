output "target_group_arns" {
  value = values(aws_lb_target_group.this)[*].arn
}