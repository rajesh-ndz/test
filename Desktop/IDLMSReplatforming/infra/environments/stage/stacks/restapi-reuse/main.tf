module "platform_rest" {
  source = "../../../../../modules/platform-restapi-reuse"

  platform_state_bucket   = var.platform_state_bucket
  platform_state_region   = var.platform_state_region
  platform_rest_state_key = var.platform_rest_state_key
}
