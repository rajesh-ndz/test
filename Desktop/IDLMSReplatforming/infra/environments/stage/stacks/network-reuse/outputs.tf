output "vpc_id" {
  value = module.platform_network.vpc_id
}
output "public_subnet_ids" {
  value = module.platform_network.public_subnet_ids
}
output "private_subnet_ids" {
  value = module.platform_network.private_subnet_ids
}
