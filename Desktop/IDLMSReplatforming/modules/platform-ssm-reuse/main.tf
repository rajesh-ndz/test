terraform { required_version = ">= 1.5.0" }

locals { prefix = trimsuffix(var.nlb_ssm_prefix, "/") }

data "aws_ssm_parameter" "lb_arn" { name = "${local.prefix}/lb_arn" }
data "aws_ssm_parameter" "lb_dns_name" { name = "${local.prefix}/lb_dns_name" }
# The following are JSON strings mapping port→ARN
data "aws_ssm_parameter" "listener_arns" { name = "${local.prefix}/listener_arns" }
data "aws_ssm_parameter" "target_group_arns" { name = "${local.prefix}/target_group_arns" }

locals {
  lb_arn            = data.aws_ssm_parameter.lb_arn.value
  lb_dns_name       = data.aws_ssm_parameter.lb_dns_name.value
  listener_arns     = jsondecode(data.aws_ssm_parameter.listener_arns.value)
  target_group_arns = jsondecode(data.aws_ssm_parameter.target_group_arns.value)
}
