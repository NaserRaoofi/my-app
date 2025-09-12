# My Project

A comprehensive DevOps project with infrastructure as code, Kubernetes deployments, and application services.

## Structure

- `infra/` - Terraform infrastructure modules and environments
- `k8s/` - Kubernetes manifests and Helm charts
- `apps/` - Application code (CLI tools, web services)
- `scripts/` - Utility automation scripts
- `.github/workflows/` - CI/CD pipelines

## Quick Start

```bash
# Setup infrastructure
make infra-dev

# Deploy applications
make k8s-deploy-dev

# Run applications locally
make app-run
```

## Environments

- **dev** - Development environment
- **staging** - Staging environment
- **prod** - Production environment
