terraform { required_version = ">= 1.5.0" }

data "terraform_remote_state" "nlb" {
  backend = "s3"
  config = {
    bucket = var.platform_state_bucket
    key    = var.platform_nlb_state_key
    region = var.platform_state_region
  }
}

locals {
  lb_arn            = try(data.terraform_remote_state.nlb.outputs.lb_arn, null)
  lb_dns_name       = try(data.terraform_remote_state.nlb.outputs.lb_dns_name, null)
  lb_zone_id        = try(data.terraform_remote_state.nlb.outputs.lb_zone_id, null)
  target_group_arns = try(data.terraform_remote_state.nlb.outputs.target_group_arns, {})
  listener_arns     = try(data.terraform_remote_state.nlb.outputs.listener_arns, {})
}
