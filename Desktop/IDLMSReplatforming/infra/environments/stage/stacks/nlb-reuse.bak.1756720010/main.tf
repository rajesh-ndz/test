module "platform_nlb" {
  source = "../../../../../modules/platform-nlb-reuse"

  platform_state_bucket  = var.platform_state_bucket
  platform_state_region  = var.platform_state_region
  platform_nlb_state_key = var.platform_nlb_state_key
}
