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
variable "platform_s3_state_key" {
  type    = string
  default = "stage/s3/terraform.tfstate"
}
