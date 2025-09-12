################################################################################
# Environment Variables
################################################################################

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
  default     = "dev"

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be one of: dev, staging, prod."
  }
}

variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "my-project"
}

variable "cost_center" {
  description = "Cost center for billing and tagging"
  type        = string
  default     = "engineering"
}

################################################################################
# Networking Variables
################################################################################

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "enable_nat_gateway" {
  description = "Enable NAT Gateway for private subnets"
  type        = bool
  default     = true
}

variable "single_nat_gateway" {
  description = "Use a single NAT Gateway for all private subnets (cost optimization)"
  type        = bool
  default     = true
}

variable "enable_flow_log" {
  description = "Enable VPC Flow Logs"
  type        = bool
  default     = true
}

################################################################################
# Feature Flags
################################################################################

variable "enable_compute" {
  description = "Enable compute resources (EC2, EKS)"
  type        = bool
  default     = false
}

variable "enable_storage" {
  description = "Enable storage resources (RDS, S3)"
  type        = bool
  default     = false
}

variable "enable_monitoring" {
  description = "Enable monitoring resources (CloudWatch, alerts)"
  type        = bool
  default     = false
}
