################################################################################
# Environment Outputs
################################################################################

# Environment Information
output "environment" {
  description = "Environment name"
  value       = var.environment
}

output "project_name" {
  description = "Project name"
  value       = var.project_name
}

output "aws_region" {
  description = "AWS region"
  value       = var.aws_region
}

################################################################################
# Networking Outputs
################################################################################

output "networking" {
  description = "Networking module outputs"
  value = {
    vpc_id                     = module.networking.vpc_id
    vpc_arn                    = module.networking.vpc_arn
    vpc_cidr_block            = module.networking.vpc_cidr_block
    private_subnets           = module.networking.private_subnets
    public_subnets            = module.networking.public_subnets
    database_subnets          = module.networking.database_subnets
    database_subnet_group_name = module.networking.database_subnet_group_name
    internet_gateway_id       = module.networking.igw_id
    nat_gateway_ips          = module.networking.nat_public_ips
  }
  sensitive = false
}

# Individual outputs for easy reference
output "vpc_id" {
  description = "VPC ID"
  value       = module.networking.vpc_id
}

output "private_subnet_ids" {
  description = "Private subnet IDs"
  value       = module.networking.private_subnets
}

output "public_subnet_ids" {
  description = "Public subnet IDs"
  value       = module.networking.public_subnets
}

output "database_subnet_group_name" {
  description = "Database subnet group name for RDS"
  value       = module.networking.database_subnet_group_name
}

################################################################################
# Future Service Outputs (when enabled)
################################################################################

# output "compute" {
#   description = "Compute module outputs"
#   value       = var.enable_compute ? module.compute[0] : null
# }

# output "storage" {
#   description = "Storage module outputs"
#   value       = var.enable_storage ? module.storage[0] : null
# }

# output "monitoring" {
#   description = "Monitoring module outputs"
#   value       = var.enable_monitoring ? module.monitoring[0] : null
# }
