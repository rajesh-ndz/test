terraform {
  required_version = ">= 1.5.0"
}

locals {
  # where NLB details live in SSM
  nlb_ssm_prefix = "/idlms/nlb/stage"
  # keep in sync with providers.tf
  region = "ap-south-1"
}

module "nlb_ssm" {
  source         = "../../../../../modules/platform-ssm-reuse"
  region         = local.region
  nlb_ssm_prefix = local.nlb_ssm_prefix
}

# Look up the NLB by ARN to derive the hosted zone id (non-sensitive)
data "aws_lb" "nlb" {
  arn = nonsensitive(module.nlb_ssm.lb_arn)
}
