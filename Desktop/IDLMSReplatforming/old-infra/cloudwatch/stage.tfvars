environment           = "stage"
region                = "ap-southeast-1"
tf_state_bucket       = "stage-btl-idlms-backend-api-tfstate-592776312448"
log_group_tag_name    = "stage-DockerAPI"
ssm_param_name        = "/stage-cloudwatch/docker-config"
docker_log_group_name = "/stage/docker/api"
ssm_tag_name          = "stage-docker-cloudwatch-config"

tf_state_region = "ap-southeast-1"
