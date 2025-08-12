region             = "eu-west-1"
environment        = "{{env}}"
stage_name         = "{{env}}-idlms"
log_retention_days = 7
api_description    = "Stage REST API to NLB"
binary_media_types = ["*/*"]

common_tags = {
  Environment = "{{env}}"
  Project     = "idlms"
  Owner       = "idlms-api"
}
throttling_rate_limit  = 300
throttling_burst_limit = 800
metrics_enabled        = true
logging_level          = "INFO"
data_trace_enabled     = false

api_port        = 4000
tf_state_bucket = "{{env}}-btl-idlms-backend-api-tfstate"
tf_state_region = "eu-west-1"
