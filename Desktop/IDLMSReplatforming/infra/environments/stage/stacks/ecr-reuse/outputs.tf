output "repository_names" {
  value = local.repository_names
}

output "repository_arns" {
  value = local.repository_arns
}
# Expecting platform-main's ECR stack to expose this output.
# If your platform-main output name differs, adjust the attribute below.
output "repository_urls" {
  value = try(data.terraform_remote_state.ecr.outputs.repository_urls, [])
}
