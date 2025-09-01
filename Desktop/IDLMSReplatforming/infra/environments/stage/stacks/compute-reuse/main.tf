module "platform_compute" {
  source = "../../../../../modules/platform-compute-reuse"

  platform_state_bucket      = var.platform_state_bucket
  platform_state_region      = var.platform_state_region
  platform_compute_state_key = var.platform_compute_state_key
}
