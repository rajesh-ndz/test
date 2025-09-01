module "platform_s3" {
  source = "../../../../../modules/platform-s3-reuse"

  platform_state_bucket = var.platform_state_bucket
  platform_state_region = var.platform_state_region
  platform_s3_state_key = var.platform_s3_state_key
}
