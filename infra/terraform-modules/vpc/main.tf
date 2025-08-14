# resource "aws_vpc" "vpc" {
#   cidr_block           = var.vpc_cidr
#   instance_tenancy     = var.instance_tenancy
#   enable_dns_support   = var.enable_dns_support
#   enable_dns_hostnames = var.enable_dns_hostnames

#   tags = merge(var.common_tags, { Name = var.vpc_name })
# }

# # Internet Gateway for Public Subnets
# resource "aws_internet_gateway" "igw" {
#   vpc_id = aws_vpc.vpc.id

#   tags = merge(var.common_tags, { Name = var.internet_gateway_name })
# }

# # Elastic IP for NAT Gateway
# resource "aws_eip" "nat_gateway" {}

# # NAT Gateway for Private Subnets
# resource "aws_nat_gateway" "nat" {
#   allocation_id = aws_eip.nat_gateway.id
#   subnet_id     = aws_subnet.public_subnets[0].id # NAT placed in first public subnet

#   tags = merge(var.common_tags, { Name = var.nat_gateway_name })
# }

# resource "aws_subnet" "public_subnets" {
#   count                   = length(var.public_subnets["cidrs_blocks"])
#   vpc_id                  = aws_vpc.vpc.id
#   cidr_block              = element(var.public_subnets["cidrs_blocks"], count.index)
#   map_public_ip_on_launch = true
#   tags                    = merge(var.common_tags, { Name = "Public Subnet ${count.index + 1}" })
# }

# resource "aws_subnet" "private_subnets" {
#   count      = length(var.private_subnets["cidrs_blocks"])
#   vpc_id     = aws_vpc.vpc.id
#   cidr_block = element(var.private_subnets["cidrs_blocks"], count.index)
#   tags       = merge(var.common_tags, { Name = "Private Subnet ${count.index + 1}" })
# }




# # Public Route Table (Routes traffic to the Internet Gateway)
# resource "aws_route_table" "public_rt" {
#   vpc_id = aws_vpc.vpc.id
#   tags   = merge(var.common_tags, { Name = "Public Route Table" })
# }

# resource "aws_route" "public_route" {
#   route_table_id         = aws_route_table.public_rt.id
#   destination_cidr_block = "0.0.0.0/0"
#   gateway_id             = aws_internet_gateway.igw.id
# }

# # Private Route Table (Routes traffic via NAT Gateway)
# resource "aws_route_table" "private_rt" {
#   vpc_id = aws_vpc.vpc.id
#   tags   = merge(var.common_tags, { Name = "Private Route Table" })
# }

# resource "aws_route" "private_route" {
#   route_table_id         = aws_route_table.private_rt.id
#   destination_cidr_block = "0.0.0.0/0"
#   nat_gateway_id         = aws_nat_gateway.nat.id
# }

# # Associate Public Subnets with Public Route Table
# resource "aws_route_table_association" "public_subnet_assoc" {
#   count          = length(aws_subnet.public_subnets)
#   subnet_id      = aws_subnet.public_subnets[count.index].id
#   route_table_id = aws_route_table.public_rt.id
# }

# # Associate Private Subnets with Private Route Table
# resource "aws_route_table_association" "private_subnet_assoc" {
#   count          = length(aws_subnet.private_subnets)
#   subnet_id      = aws_subnet.private_subnets[count.index].id
#   route_table_id = aws_route_table.private_rt.id
# }

# --- New: discover AZs and set locals for AZ spreading ---
data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  # Use user-provided AZs if given, otherwise take all AZs in the region
  azs = length(var.azs) > 0 ? var.azs : data.aws_availability_zones.available.names

  # Also used by outputs to pick first 3 AZs for VPC Link
  vpc_link_supported_azs = slice(local.azs, 0, min(3, length(local.azs)))
}

resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = var.instance_tenancy
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames

  tags = merge(var.common_tags, { Name = var.vpc_name })
}

# Internet Gateway for Public Subnets
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags   = merge(var.common_tags, { Name = var.internet_gateway_name })
}

# Elastic IP for NAT Gateway
resource "aws_eip" "nat_gateway" {}

# NAT Gateway for Private Subnets
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_gateway.id
  subnet_id     = aws_subnet.public_subnets[0].id # NAT placed in first public subnet
  tags          = merge(var.common_tags, { Name = var.nat_gateway_name })
}

# -------------- CHANGED: assign AZ per public subnet --------------
resource "aws_subnet" "public_subnets" {
  count                   = length(var.public_subnets["cidrs_blocks"])
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = element(var.public_subnets["cidrs_blocks"], count.index)
  availability_zone       = local.azs[count.index % length(local.azs)]
  map_public_ip_on_launch = var.public_subnets["map_public_ip_on_launch"]
  tags                    = merge(var.common_tags, { Name = "Public Subnet ${count.index + 1}" })
}

# -------------- CHANGED: assign AZ per private subnet --------------
resource "aws_subnet" "private_subnets" {
  count             = length(var.private_subnets["cidrs_blocks"])
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = element(var.private_subnets["cidrs_blocks"], count.index)
  availability_zone = local.azs[count.index % length(local.azs)]
  tags              = merge(var.common_tags, { Name = "Private Subnet ${count.index + 1}" })
}

# Public Route Table (Routes traffic to the Internet Gateway)
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.vpc.id
  tags   = merge(var.common_tags, { Name = "Public Route Table" })
}

resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

# Private Route Table (Routes traffic via NAT Gateway)
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.vpc.id
  tags   = merge(var.common_tags, { Name = "Private Route Table" })
}

resource "aws_route" "private_route" {
  route_table_id         = aws_route_table.private_rt.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat.id
}

# Associate Public Subnets with Public Route Table
resource "aws_route_table_association" "public_subnet_assoc" {
  count          = length(aws_subnet.public_subnets)
  subnet_id      = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.public_rt.id
}

# Associate Private Subnets with Private Route Table
resource "aws_route_table_association" "private_subnet_assoc" {
  count          = length(aws_subnet.private_subnets)
  subnet_id      = aws_subnet.private_subnets[count.index].id
  route_table_id = aws_route_table.private_rt.id
}
