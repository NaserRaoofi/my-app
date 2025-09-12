# VPC Resources Summary

## ✅ RESOURCES THAT WILL BE CREATED (Only ~15 resources):

### Core VPC

1. `aws_vpc.this` - The main VPC (10.0.0.0/16)

### Subnets (9 subnets total)

2. `aws_subnet.public[0-2]` - 3 public subnets (10.0.101-103.0/24)
3. `aws_subnet.private[0-2]` - 3 private subnets (10.0.1-3.0/24)
4. `aws_subnet.database[0-2]` - 3 database subnets (10.0.201-203.0/24)

### Networking

5. `aws_internet_gateway.this` - Internet access for public subnets
6. `aws_eip.nat[0]` - 1 Elastic IP for NAT Gateway
7. `aws_nat_gateway.this[0]` - 1 NAT Gateway for private subnet internet

### Route Tables & Routes

8. `aws_route_table.public[0]` - 1 public route table
9. `aws_route_table.private[0-2]` - 3 private route tables
10. `aws_route_table.database[0-2]` - 3 database route tables
11. `aws_route.public_internet_gateway[0]` - Public -> IGW route
12. `aws_route.private_nat_gateway[0-2]` - Private -> NAT routes
13. `aws_route.database_nat_gateway[0-2]` - Database -> NAT routes

### Route Table Associations

14. `aws_route_table_association.public[0-2]` - Associate public subnets
15. `aws_route_table_association.private[0-2]` - Associate private subnets
16. `aws_route_table_association.database[0-2]` - Associate DB subnets

### Database

17. `aws_db_subnet_group.database` - RDS subnet group

### Monitoring (Optional)

18. `aws_flow_log.this` - VPC flow logs
19. `aws_cloudwatch_log_group.flow_log` - CloudWatch log group for flow logs
20. `aws_iam_role.vpc_flow_log_cloudwatch` - IAM role for flow logs
21. `aws_iam_policy.vpc_flow_log_cloudwatch` - IAM policy for flow logs
22. `aws_iam_role_policy_attachment.vpc_flow_log_cloudwatch` - Policy attachment

## ❌ RESOURCES THAT WILL NOT BE CREATED (60+ disabled):

### Disabled Subnets

- ❌ `aws_subnet.elasticache` - No ElastiCache subnets
- ❌ `aws_subnet.redshift` - No Redshift subnets
- ❌ `aws_subnet.intra` - No isolated subnets
- ❌ `aws_subnet.outpost` - No Outpost subnets

### Disabled Subnet Groups

- ❌ `aws_elasticache_subnet_group` - Not creating
- ❌ `aws_redshift_subnet_group` - Not creating

### Disabled VPN

- ❌ `aws_vpn_gateway.this` - No VPN gateway
- ❌ `aws_customer_gateway.this` - No customer gateway
- ❌ `aws_vpn_gateway_attachment.this` - No VPN attachment
- ❌ `aws_vpn_gateway_route_propagation.*` - No VPN propagation

### Disabled IPv6

- ❌ All IPv6 routes - IPv6 disabled

### Disabled Default Resource Management

- ❌ `aws_default_vpc.this` - Not managing default VPC
- ❌ `aws_default_security_group.this` - Not managing default SG
- ❌ `aws_default_network_acl.this` - Not managing default ACL
- ❌ `aws_default_route_table.default` - Not managing default RT

### Disabled Network ACLs

- ❌ `aws_network_acl.*` - Using Security Groups instead
- ❌ `aws_network_acl_rule.*` - No custom ACL rules

### Disabled VPC Features

- ❌ `aws_vpc_dhcp_options.*` - Using AWS defaults
- ❌ `aws_vpc_block_public_access_*` - Using AWS defaults
- ❌ `aws_egress_only_internet_gateway.this` - No IPv6

### Disabled VPC Endpoints

- ❌ `aws_vpc_endpoint.this` - No endpoints configured
- ❌ `aws_security_group.this` (endpoints) - No endpoint SG
- ❌ `aws_security_group_rule.this` (endpoints) - No endpoint rules

## 💰 COST ESTIMATE:

- VPC: Free
- Subnets: Free
- Internet Gateway: Free
- NAT Gateway: ~$45/month (main cost)
- Elastic IP: Free (while attached)
- Route Tables: Free
- Flow Logs: ~$0.50/month (small CloudWatch cost)

**Total: ~$45-50/month**

## 🔧 TO REDUCE COSTS FURTHER:

```hcl
# Disable flow logs
enable_flow_log = false

# Use NAT instance instead of NAT Gateway (more complex but cheaper)
# Or disable NAT entirely if private subnets don't need internet
enable_nat_gateway = false
```
