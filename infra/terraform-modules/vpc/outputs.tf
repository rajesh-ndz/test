# # --- VPC Outputs ---

# # VPC ID
# output "vpc_id" {
#   description = "VPC ID"
#   value       = aws_vpc.vpc.id
# }

# # Default Security Group ID
# output "default_security_group_id" {
#   description = "The default security group ID of the VPC"
#   value       = aws_vpc.vpc.default_security_group_id
# }

# # --- Public Subnet Outputs ---

# # Public Subnet IDs
# output "public_subnets_ids" {
#   description = "IDs of the public subnets"
#   value       = aws_subnet.public_subnets[*].id
# }

# # Public Subnet CIDRs
# output "public_subnets_cidrs" {
#   description = "CIDR blocks of the public subnets"
#   value       = aws_subnet.public_subnets[*].cidr_block
# }

# # --- Private Subnet Outputs ---

# # Private Subnet IDs
# output "private_subnets_ids" {
#   description = "IDs of the private subnets"
#   value       = aws_subnet.private_subnets[*].id
# }

# # Private Subnet CIDRs
# output "private_subnets_cidrs" {
#   description = "CIDR blocks of the private subnets"
#   value       = aws_subnet.private_subnets[*].cidr_block
# }

# # Private Subnets in AZs supported by API Gateway VPC Link (us-east-1a/b/c)
# output "vpc_link_subnet_ids" {
#   description = "Private subnet IDs in supported AZs for API Gateway VPC Link"
#   value = [
#     for s in aws_subnet.private_subnets :
#     s.id if contains(["ap-southeast-1a", "ap-southeast-1b", "ap-southeast-1c"], s.availability_zone)
#   ]
# }

# output "private_subnets_azs" {
#   description = "AZs of the private subnets"
#   value       = aws_subnet.private_subnets[*].availability_zone
# }

# --- VPC Outputs ---

output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.vpc.id
}

output "default_security_group_id" {
  description = "The default security group ID of the VPC"
  value       = aws_vpc.vpc.default_security_group_id
}

# --- Public Subnet Outputs ---

output "public_subnets_ids" {
  description = "IDs of the public subnets"
  value       = aws_subnet.public_subnets[*].id
}

output "public_subnets_cidrs" {
  description = "CIDR blocks of the public subnets"
  value       = aws_subnet.public_subnets[*].cidr_block
}

# (optional but useful)
output "public_subnets_azs" {
  description = "AZs of the public subnets"
  value       = aws_subnet.public_subnets[*].availability_zone
}

# --- Private Subnet Outputs ---

output "private_subnets_ids" {
  description = "IDs of the private subnets"
  value       = aws_subnet.private_subnets[*].id
}

output "private_subnets_cidrs" {
  description = "CIDR blocks of the private subnets"
  value       = aws_subnet.private_subnets[*].cidr_block
}

output "private_subnets_azs" {
  description = "AZs of the private subnets"
  value       = aws_subnet.private_subnets[*].availability_zone
}

# --- CHANGED: Region-agnostic VPC Link subnet selection (first 3 AZs in region) ---
output "vpc_link_subnet_ids" {
  description = "Private subnet IDs in selected AZs for API Gateway VPC Link"
  value = [
    for s in aws_subnet.private_subnets :
    s.id if contains(local.vpc_link_supported_azs, s.availability_zone)
  ]
}
