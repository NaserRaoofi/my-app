# Kubernetes Charts

This directory contains Helm charts for deploying applications.

## Structure

- `my-app/` - Main application chart
- `dependencies/` - Third-party charts
- `values/` - Environment-specific values

## Usage

```bash
# Install chart
helm install my-app ./charts/my-app

# Upgrade chart
helm upgrade my-app ./charts/my-app

# Uninstall chart
helm uninstall my-app
```
