tf_state_bucket    = "btl-dev-btl-idlms-backend-api-tfstate-544607260651"
environment        = "btl-dev"
region             = "ap-southeast-1"
tf_state_region    = "ap-southeast-1"
load_balancer_type = "network"
internal           = true
target_port        = 4000
lb_create_sg       = true
additional_ports   = [4000, 4001, 4002]

lb_egress_roles = [
  {
    description      = "Allow all outbound"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = []
    security_groups  = []
    self             = false
  }
]

common_tags = {
  Environment = "btl-dev"
  Project     = "IDLMS"
}
ssm_param_name = "/btl-dev-cloudwatch/docker-config"
ssm_tag_name   = "btl-dev-docker-cloudwatch-config"

