output "lb_arn" {
  value     = module.nlb_ssm.lb_arn
  sensitive = true
}

output "lb_dns_name" {
  value     = module.nlb_ssm.lb_dns_name
  sensitive = true
}

output "listener_arns" {
  value     = module.nlb_ssm.listener_arns
  sensitive = true
}

output "target_group_arns" {
  value     = module.nlb_ssm.target_group_arns
  sensitive = true
}

# derived via aws_lb data source; not sensitive
output "lb_zone_id" {
  value = data.aws_lb.nlb.zone_id
}
