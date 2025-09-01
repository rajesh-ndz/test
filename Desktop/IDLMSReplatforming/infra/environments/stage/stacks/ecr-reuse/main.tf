terraform { required_version = ">= 1.5.0" }

locals {
  platform_state_bucket  = "idlms-terraform-state-backend"
  platform_state_region  = "ap-south-1"
  platform_ecr_state_key = "stage/ecr/terraform.tfstate"
}

data "terraform_remote_state" "ecr" {
  backend = "s3"
  config = {
    bucket = local.platform_state_bucket
    key    = local.platform_ecr_state_key
    region = local.platform_state_region
  }
}

locals {
  repository_names = try(data.terraform_remote_state.ecr.outputs.repository_names, [])
  repository_urls  = try(data.terraform_remote_state.ecr.outputs.repository_urls, [])
  repository_arns  = try(data.terraform_remote_state.ecr.outputs.repository_arns, [])
}
