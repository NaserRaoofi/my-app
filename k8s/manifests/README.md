# Kubernetes Manifests

This directory contains raw Kubernetes YAML manifests.

## Structure
- `base/` - Base configurations
- `overlays/` - Environment-specific overlays (dev, staging, prod)
- `secrets/` - Secret configurations (not committed to git)

## Usage
```bash
# Apply manifests
kubectl apply -f manifests/

# Apply with kustomize
kubectl apply -k manifests/overlays/dev
```
