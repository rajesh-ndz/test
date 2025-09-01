terraform { required_version = ">= 1.5.0" }

data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = var.platform_state_bucket
    key    = var.platform_network_state_key
    region = var.platform_state_region
  }
}

locals {
  vpc_id             = try(data.terraform_remote_state.network.outputs.vpc_id, null)
  public_subnet_ids  = try(data.terraform_remote_state.network.outputs.public_subnet_ids, [])
  private_subnet_ids = try(data.terraform_remote_state.network.outputs.private_subnet_ids, [])
}
