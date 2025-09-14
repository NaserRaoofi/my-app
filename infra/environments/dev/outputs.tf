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
# Bastion Outputs
################################################################################

output "bastion" {
  description = "Bastion host information and connection details"
  value = {
    auto_scaling_group_name           = module.bastion.bastion_host_id
    security_group_id                 = module.bastion.bastion_security_group_id
    private_instances_security_group_id = module.bastion.private_instances_security_group_id
    logs_bucket_name                  = module.bastion.bastion_logs_bucket_name
    logs_bucket_arn                   = module.bastion.bastion_logs_bucket_arn
    connection_info                   = module.bastion.bastion_connection_info
    ssh_usage_examples               = module.bastion.ssh_usage_examples
  }
  sensitive = false
}
