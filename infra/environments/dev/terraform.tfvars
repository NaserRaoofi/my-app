# Environment Configuration
aws_region   = "us-east-1"
project_name = "my-project"
environment  = "dev"
cost_center  = "engineering"

# Networking Configuration
vpc_cidr           = "10.0.0.0/16"
enable_nat_gateway = true
single_nat_gateway = true  # Cost optimization for dev
enable_flow_log    = true

# Feature Flags - Enable services as needed
enable_compute    = false  # Set to true when you want EC2/EKS
enable_storage    = false  # Set to true when you want RDS/S3
enable_monitoring = false  # Set to true when you want CloudWatch
