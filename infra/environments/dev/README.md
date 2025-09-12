# Development Environment

A scalable, service-oriented Terraform configuration for the development environment.

## 🏗️ Architecture

```
dev/
├── main.tf                 # 🎯 Main orchestration file
├── variables.tf            # 📝 Environment variables
├── outputs.tf             # 📤 Environment outputs
├── terraform.tfvars       # ⚙️ Configuration values
├── versions.tf            # 🔒 Provider requirements
│
└── services/              # 🔧 Service modules
    ├── networking/        # 🌐 VPC, subnets, gateways
    │   ├── vpc.tf
    │   ├── variables.tf
    │   └── outputs.tf
    ├── compute/           # 💻 EC2, EKS, ALB (future)
    ├── storage/           # 🗄️ RDS, S3, DynamoDB (future)
    ├── security/          # 🔒 Security Groups, IAM (future)
    └── monitoring/        # 📊 CloudWatch, alarms (future)
```

## 🚀 Quick Start

### 1. Deploy Networking Only (Current)

```bash
cd /home/sirwan/terr/infra/environments/dev
terraform init
terraform plan
terraform apply
```

### 2. Add More Services Later

Edit `terraform.tfvars`:

```hcl
enable_compute    = true   # Enable EC2/EKS
enable_storage    = true   # Enable RDS/S3
enable_monitoring = true   # Enable CloudWatch
```

Uncomment the relevant modules in `main.tf` and run:

```bash
terraform plan
terraform apply
```

## 📋 Service Status

| Service       | Status          | Description                         |
| ------------- | --------------- | ----------------------------------- |
| 🌐 Networking | ✅ **Active**   | VPC, subnets, NAT, IGW              |
| 💻 Compute    | ⏳ **Template** | EC2, EKS, ALB (ready to add)        |
| 🗄️ Storage    | ⏳ **Template** | RDS, S3, DynamoDB (ready to add)    |
| 🔒 Security   | ⏳ **Template** | Security Groups, IAM (ready to add) |
| 📊 Monitoring | ⏳ **Template** | CloudWatch, alarms (ready to add)   |

## 🎛️ Configuration

### Current Configuration (terraform.tfvars)

```hcl
# Environment
aws_region   = "us-east-1"
project_name = "my-project"
environment  = "dev"

# Networking
vpc_cidr           = "10.0.0.0/16"
enable_nat_gateway = true
single_nat_gateway = true  # Cost optimization
enable_flow_log    = true

# Feature Flags
enable_compute    = false  # Not yet implemented
enable_storage    = false  # Not yet implemented
enable_monitoring = false  # Not yet implemented
```

## 🔗 Dependencies

### Service Dependencies

```
main.tf
  ├── networking/ (no dependencies)
  ├── compute/ (depends on: networking)
  ├── storage/ (depends on: networking)
  ├── security/ (depends on: networking)
  └── monitoring/ (depends on: all services)
```

### Outputs Flow

```
networking.vpc_id → compute.vpc_id
networking.private_subnets → compute.subnet_ids
networking.database_subnet_group → storage.subnet_group
```

## 📊 Current Resources

**Will Create (~22 resources):**

- VPC with 3 AZs
- 3 public + 3 private + 3 database subnets
- 1 Internet Gateway
- 1 NAT Gateway + Elastic IP
- Route tables and associations
- Database subnet group
- VPC Flow Logs + CloudWatch

**Cost: ~$45-50/month** (mainly NAT Gateway)

## 🎯 Benefits of This Structure

### ✅ **Scalability**

- Add services incrementally
- Clear separation of concerns
- Reusable service modules

### ✅ **Maintainability**

- Each service in its own directory
- Clear dependencies
- Consistent naming and tagging

### ✅ **Flexibility**

- Feature flags to enable/disable services
- Environment-specific configurations
- Easy to replicate for staging/prod

### ✅ **Best Practices**

- DRY principle (Don't Repeat Yourself)
- Single responsibility modules
- Infrastructure as Code standards

## 🚀 Next Steps

1. **Test Current Setup**

   ```bash
   terraform plan  # Verify configuration
   terraform apply # Deploy networking
   ```

2. **Add Compute Resources**

   - Create EC2 instances in `services/compute/`
   - Add security groups in `services/security/`
   - Enable load balancer

3. **Add Storage Resources**

   - Create RDS database in `services/storage/`
   - Add S3 buckets for application data
   - Configure backup strategies

4. **Add Monitoring**
   - CloudWatch dashboards
   - Application and infrastructure alarms
   - Log aggregation

## 🔧 Customization

### Add a New Service

1. Create directory: `services/new-service/`
2. Add module files: `variables.tf`, `main.tf`, `outputs.tf`
3. Add module call to main `main.tf`
4. Add feature flag to `variables.tf` and `terraform.tfvars`

### Change Configuration

- **Networking**: Edit `services/networking/vpc.tf`
- **Environment**: Edit `terraform.tfvars`
- **New Services**: Add to `main.tf` and create service directory
