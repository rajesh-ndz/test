output "lb_arn" {
  value = module.platform_nlb.lb_arn
}
output "lb_dns_name" {
  value = module.platform_nlb.lb_dns_name
}
output "lb_zone_id" {
  value = module.platform_nlb.lb_zone_id
}
output "target_group_arns" {
  value = module.platform_nlb.target_group_arns
}
output "listener_arns" {
  value = module.platform_nlb.listener_arns
}
