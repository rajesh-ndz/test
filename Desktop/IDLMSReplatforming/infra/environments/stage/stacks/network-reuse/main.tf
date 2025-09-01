module "platform_network" {
  source = "../../../../../modules/platform-network-reuse"

  platform_state_bucket      = var.platform_state_bucket
  platform_state_region      = var.platform_state_region
  platform_network_state_key = var.platform_network_state_key
}
