terraform { required_version = ">= 1.5.0" }

data "terraform_remote_state" "s3" {
  backend = "s3"
  config = {
    bucket = var.platform_state_bucket
    key    = var.platform_s3_state_key
    region = var.platform_state_region
  }
}

locals {
  bucket_name           = try(data.terraform_remote_state.s3.outputs.bucket_name, null)
  bucket_arn            = try(data.terraform_remote_state.s3.outputs.bucket_arn, null)
  ssm_bucket_name_param = try(data.terraform_remote_state.s3.outputs.ssm_bucket_name_param, null)
  ssm_bucket_arn_param  = try(data.terraform_remote_state.s3.outputs.ssm_bucket_arn_param, null)
}
