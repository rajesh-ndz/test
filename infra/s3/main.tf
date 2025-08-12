# data "aws_caller_identity" "current" {}

resource "aws_s3_bucket" "artifact" {
  bucket = "test-s3-idlmreplatforming-artifact"

  tags = {
    Name        = "IDLMS ${var.environment} Artifact Bucket"
    Environment = var.environment
  }

  force_destroy = true
}

resource "aws_s3_bucket_versioning" "artifact_versioning" {
  bucket = aws_s3_bucket.artifact.id

  versioning_configuration {
    status = var.enable_versioning ? "Enabled" : "Suspended"
  }
}
