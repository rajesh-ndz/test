variable "region" {
  type    = string
  default = "ap-south-1"
}
variable "platform_state_bucket" {
  type    = string
  default = "idlms-terraform-state-backend"
}
variable "platform_state_region" {
  type    = string
  default = "ap-south-1"
}
variable "platform_observability_state_key" {
  type    = string
  default = "stage/observability/terraform.tfstate"
}
