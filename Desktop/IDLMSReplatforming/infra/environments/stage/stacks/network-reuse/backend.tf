terraform {
  backend "s3" {
    bucket = "idlms-terraform-state-backend"
    key    = "IDLMSReplatforming/stage/stacks/network-reuse/terraform.tfstate"
    region = "ap-south-1"
    # dynamodb_table = "idlms-terraform-locks"   # optional
    encrypt = true
  }
}
