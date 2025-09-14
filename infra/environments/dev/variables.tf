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

################################################################################
# Bastion Host Variables
################################################################################

variable "bastion_key_pair_name" {
  description = "EC2 Key Pair name for bastion host SSH access"
  type        = string
}

variable "bastion_instance_type" {
  description = "EC2 instance type for bastion host"
  type        = string
  default     = "t3.micro"
}

variable "bastion_allowed_cidrs" {
  description = "List of CIDR blocks allowed to SSH to bastion host"
  type        = list(string)
  default     = ["0.0.0.0/0"]  # Restrict this in production!
}
