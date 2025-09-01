output "bucket_name" {
  value = module.platform_s3.bucket_name
}
output "bucket_arn" {
  value = module.platform_s3.bucket_arn
}
output "ssm_bucket_name_param" {
  value = module.platform_s3.ssm_bucket_name_param
}
output "ssm_bucket_arn_param" {
  value = module.platform_s3.ssm_bucket_arn_param
}
