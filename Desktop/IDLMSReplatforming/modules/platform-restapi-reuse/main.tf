terraform { required_version = ">= 1.5.0" }

data "terraform_remote_state" "rest" {
  backend = "s3"
  config = {
    bucket = var.platform_state_bucket
    key    = var.platform_rest_state_key
    region = var.platform_state_region
  }
}

locals {
  rest_api_id      = try(data.terraform_remote_state.rest.outputs.rest_api_id, null)
  invoke_url       = try(data.terraform_remote_state.rest.outputs.invoke_url, null)
  vpc_link_id      = try(data.terraform_remote_state.rest.outputs.vpc_link_id, null)
  access_log_group = try(data.terraform_remote_state.rest.outputs.access_log_group, null)
  stage_name       = try(data.terraform_remote_state.rest.outputs.stage_name, null)
}
