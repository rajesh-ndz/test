variable "pm_state_bucket" {
  type = string
} # e.g., "idlms-terraform-state-backend"
variable "pm_state_region" {
  type = string
} # e.g., "ap-south-1"
variable "pm_ecr_state_key" {
  type = string
} # e.g., "stage/ecr/terraform.tfstate"
