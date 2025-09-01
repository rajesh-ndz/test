module "nlb_ssm" {
  source = "../../../../../modules/platform-ssm-reuse"


  region         = var.region
  nlb_ssm_prefix = var.nlb_ssm_prefix
}
