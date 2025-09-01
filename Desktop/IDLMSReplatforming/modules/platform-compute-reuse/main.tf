terraform { required_version = ">= 1.5.0" }

data "terraform_remote_state" "compute" {
  backend = "s3"
  config = {
    bucket = var.platform_state_bucket
    key    = var.platform_compute_state_key
    region = var.platform_state_region
  }
}

locals {
  instance_id         = try(data.terraform_remote_state.compute.outputs.instance_id, null)
  security_group_id   = try(data.terraform_remote_state.compute.outputs.security_group_id, null)
  instance_private_ip = try(data.terraform_remote_state.compute.outputs.instance_private_ip, null)
}
