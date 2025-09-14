################################################################################
# Networking Service - Main Configuration
################################################################################

# This service manages all networking resources for the environment
# It calls the VPC module with environment-specific configuration

module "vpc" {
  source = "github.com/NaserRaoofi/terraform-aws-modules//modules/networking?ref=main"

  # ================================
  # ✅ ENABLED RESOURCES
  # ================================

  # Basic VPC Configuration
  name = var.name_prefix
  cidr = var.vpc_cidr

  # Availability Zones - Multiple AZs required for EKS
  azs = [var.azs[0], var.azs[1]]  # Use first two AZs

  # Subnets - Two public and two private subnets for EKS
  public_subnets  = [cidrsubnet(var.vpc_cidr, 8, 1), cidrsubnet(var.vpc_cidr, 8, 3)]   # e.g., 10.0.1.0/24, 10.0.3.0/24
  private_subnets = [cidrsubnet(var.vpc_cidr, 8, 2), cidrsubnet(var.vpc_cidr, 8, 4)]   # e.g., 10.0.2.0/24, 10.0.4.0/24

  # Internet connectivity - Essential for public subnet
  map_public_ip_on_launch = true  # Auto-assign public IPs in public subnet

  # DNS - Essential for proper hostname resolution
  enable_dns_hostnames = true
  enable_dns_support   = true

  # Internet Gateway - Required for public subnet internet access
  create_igw = true

  # Route tables - Best practice configuration
  manage_default_route_table = true
  default_route_table_tags = {
    Name = "${var.name_prefix}-default-rt"
  }

  # Tags
  tags = var.common_tags
  vpc_tags = {
    Name = "${var.name_prefix}-vpc"
  }

  public_subnet_tags = {
    Name = "${var.name_prefix}-public-subnet"
    Type = "public"
    Tier = "public"
    "kubernetes.io/role/elb" = "1"  # For future ALB use
  }

  private_subnet_tags = {
    Name = "${var.name_prefix}-private-subnet"
    Type = "private"
    Tier = "private"
    "kubernetes.io/role/internal-elb" = "1"  # For future internal LB use
  }

  public_route_table_tags = {
    Name = "${var.name_prefix}-public-rt"
  }

  private_route_table_tags = {
    Name = "${var.name_prefix}-private-rt"
  }

  # ================================
  # ❌ EXPLICITLY DISABLED RESOURCES
  # ================================
  create_egress_only_igw = false
  create_elasticache_subnet_group = false  # Default: true
  create_redshift_subnet_group = false
  # NAT Gateway - Disabled (using bastion for private subnet internet access)
  # NAT disabled; rely on VPC endpoints + bastion for private access
  enable_nat_gateway = false

  # ================================
  # 🛡️ SECURITY FLAGS
  # ================================
  putin_khuylo = true  # Required for module to work
}

################################################################################
# VPC Endpoints for EKS without NAT Gateway
################################################################################

module "vpc_endpoints" {
  source = "github.com/NaserRaoofi/terraform-aws-modules//modules/networking/modules/vpc-endpoints?ref=main"

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  # Security group for VPC endpoints
  create_security_group = true
  security_group_name   = "${var.name_prefix}-vpc-endpoints-sg"
  security_group_description = "Security group for VPC endpoints"

  # Security group rules - allow HTTPS from private subnets
  security_group_rules = {
    ingress_https = {
      description = "HTTPS from private subnets"
      type        = "ingress"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = module.vpc.private_subnets_cidr_blocks
    }
    egress_all = {
      description = "All outbound traffic"
      type        = "egress"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  # Essential endpoints for EKS
  endpoints = {
    # S3 Gateway endpoint for ECR images (free)
    s3 = {
      service = "s3"
      service_type = "Gateway"
      route_table_ids = module.vpc.private_route_table_ids
      tags = { Name = "${var.name_prefix}-s3-gateway" }
    }

    # Interface endpoints (cost money but necessary for EKS)
    ec2 = {
      service = "ec2"
      private_dns_enabled = true
      tags = { Name = "${var.name_prefix}-ec2" }
    }

    ecr_api = {
      service = "ecr.api"
      private_dns_enabled = true
      tags = { Name = "${var.name_prefix}-ecr-api" }
    }

    ecr_dkr = {
      service = "ecr.dkr"
      private_dns_enabled = true
      tags = { Name = "${var.name_prefix}-ecr-dkr" }
    }

    eks = {
      service = "eks"
      private_dns_enabled = true
      tags = { Name = "${var.name_prefix}-eks" }
    }

    sts = {
      service = "sts"
      private_dns_enabled = true
      tags = { Name = "${var.name_prefix}-sts" }
    }

    logs = {
      service = "logs"
      private_dns_enabled = true
      tags = { Name = "${var.name_prefix}-logs" }
    }

    ssm = {
      service = "ssm"
      private_dns_enabled = true
      tags = { Name = "${var.name_prefix}-ssm" }
    }

    # Additional endpoints required for SSM Session Manager
    ssmmessages = {
      service = "ssmmessages"
      private_dns_enabled = true
      tags = { Name = "${var.name_prefix}-ssmmessages" }
    }

    ec2messages = {
      service = "ec2messages"
      private_dns_enabled = true
      tags = { Name = "${var.name_prefix}-ec2messages" }
    }
  }

  tags = var.common_tags
}
