terraform {
  backend "s3" {
    bucket         = "idlms-terraform-state-backend"
    key            = "stage/compute/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "idlms-terraform-state-locks" # if you are using a lock table
  }
}
