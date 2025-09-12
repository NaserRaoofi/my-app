################################################################################
# Networking Service - Main Configuration
################################################################################

# This service manages all networking resources for the environment
# It calls the VPC module with environment-specific configuration

module "vpc" {
  source = "git::https://github.com/NaserRaoofi/terraform-modules.git//modules/networking"

  # ================================
  # ✅ ENABLED RESOURCES
  # ================================

  # Basic VPC Configuration
  name = var.name_prefix
  cidr = var.vpc_cidr

  # Availability Zones
  azs = var.azs

  # Subnets - ONLY what we need
  private_subnets  = [for k, v in var.azs : cidrsubnet(var.vpc_cidr, 8, k + 1)]
  public_subnets   = [for k, v in var.azs : cidrsubnet(var.vpc_cidr, 8, k + 101)]
  database_subnets = [for k, v in var.azs : cidrsubnet(var.vpc_cidr, 8, k + 201)]

  # Internet connectivity - Essential=
  # DNS - Essential
  enable_dns_hostnames = true
  enable_dns_support   = true


  # Essential route tables
  manage_default_route_table = true

  # Tags
  tags = var.common_tags
  vpc_tags = {
    Name = "${var.name_prefix}-vpc"
  }

  private_subnet_tags = {
    Type = "private"
    Tier = "private"
  }

  public_subnet_tags = {
    Type = "public"
    Tier = "public"
    "kubernetes.io/role/elb" = "1"  # For future ALB use
  }

  database_subnet_tags = {
    Type = "database"
    Tier = "data"
  }

  # ================================
  # ❌ EXPLICITLY DISABLED RESOURCES
  # ================================


  # NAT Gateway disabled
  enable_nat_gateway = false
  single_nat_gateway = false

  # IPv6 - Not needed for basic setup
  enable_ipv6                                = false
  public_subnet_assign_ipv6_address_on_creation  = false
  private_subnet_assign_ipv6_address_on_creation = false

  # Additional subnet types - Disabled for now
  intra_subnets       = []  # No intra subnets
  elasticache_subnets = []  # No ElastiCache subnets
  redshift_subnets    = []  # No Redshift subnets
  outpost_subnets     = []  # No Outpost subnets

  # Route table options - Keep simple
  create_multiple_public_route_tables  = false
  create_multiple_intra_route_tables   = false

  # Advanced networking - Disabled
  create_egress_only_igw              = false
  create_database_internet_gateway_route = false
  create_database_nat_gateway_route      = false

  # DHCP options - Use defaults
  enable_dhcp_options              = false
  dhcp_options_domain_name         = ""
  dhcp_options_domain_name_servers = []

  # VPN Gateway - Not needed
  enable_vpn_gateway = false
  vpn_gateway_id     = ""
  vpn_gateway_az     = ""

  # Customer Gateway - Not needed
  customer_gateways = {}

  # Default security group - Manage separately
  manage_default_security_group = false

  # Network ACLs - Manage separately if needed
  manage_default_network_acl    = false
  public_dedicated_network_acl  = false
  private_dedicated_network_acl = false
  intra_dedicated_network_acl   = false
  database_dedicated_network_acl = false
  redshift_dedicated_network_acl = false
  elasticache_dedicated_network_acl = false
  outpost_dedicated_network_acl     = false

  # ================================
  # 🛡️ SECURITY FLAGS
  # ================================
  putin_khuylo = true  # Required for module to work
}
