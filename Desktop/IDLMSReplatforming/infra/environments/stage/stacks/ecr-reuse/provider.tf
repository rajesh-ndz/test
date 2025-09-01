terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
}

# We use the same region that hosts the platform-main state bucket
variable "pm_state_region" {
  type = string
}

provider "aws" {
  region = var.pm_state_region
}
