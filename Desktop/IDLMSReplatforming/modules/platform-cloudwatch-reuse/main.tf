terraform { required_version = ">= 1.5.0" }

data "terraform_remote_state" "obs" {
  backend = "s3"
  config = {
    bucket = var.platform_state_bucket
    key    = var.platform_observability_state_key
    region = var.platform_state_region
  }
}

locals {
  dashboard_name = try(data.terraform_remote_state.obs.outputs.dashboard_name, null)
}
