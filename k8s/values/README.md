# Helm Values

This directory contains Helm values files for different environments.

## Structure

- `dev/` - Development environment values
- `staging/` - Staging environment values
- `prod/` - Production environment values
- `common/` - Shared values across environments

## Usage

```bash
# Deploy with specific values
helm install my-app ./charts/my-app -f values/dev/values.yaml

# Override specific values
helm install my-app ./charts/my-app -f values/dev/values.yaml --set image.tag=v1.2.3
```
