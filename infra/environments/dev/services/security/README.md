# Security Service Module

This module will contain:

- Security Groups
- NACLs
- WAF rules
- IAM roles and policies
- Secrets Manager
- Certificate Manager

## Usage

Uncomment the security module in `main.tf`

```hcl
module "security" {
  source = "./services/security"

  # Dependencies
  vpc_id = module.networking.vpc_id

  # Common variables
  environment = local.environment
  name_prefix = local.name_prefix
  common_tags = local.common_tags
}
```
