tf_state_bucket = "test-s3-idlmreplatforming-tfstate"
tf_state_region  = "ap-southeast-1"
region          = "ap-southeast-1"
environment     = "dev"
load_balancer_type = "network"
internal           = true
target_port        = 4000
additional_ports = [4000, 4001, 4002]
lb_create_sg       = true
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
  Environment = "dev"
  Project     = "IDMS"
}

ssm_param_name         = "/dev-cloudwatch/docker-config"
ssm_tag_name           = "dev-docker-cloudwatch-config"

