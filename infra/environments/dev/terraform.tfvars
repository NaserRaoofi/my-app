# Environment Configuration
aws_region   = "us-east-1"
project_name = "my-project"
environment  = "dev"
cost_center  = "engineering"

# Networking Configuration
vpc_cidr = "10.0.0.0/16"

# Bastion Configuration
bastion_key_pair_name = "my-key-pair"  # Replace with your actual EC2 key pair name
bastion_instance_type = "t3.micro"
bastion_allowed_cidrs = ["0.0.0.0/0"]  # Restrict this to your IP in production
