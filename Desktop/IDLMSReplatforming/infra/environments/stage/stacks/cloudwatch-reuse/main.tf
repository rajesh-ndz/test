module "platform_obs" {
  source = "../../../../../modules/platform-cloudwatch-reuse"

  platform_state_bucket            = var.platform_state_bucket
  platform_state_region            = var.platform_state_region
  platform_observability_state_key = var.platform_observability_state_key
}
