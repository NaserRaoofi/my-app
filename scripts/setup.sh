#!/bin/bash
set -e

echo "🚀 Setting up My Project..."

# Check prerequisites
command -v terraform >/dev/null 2>&1 || { echo "❌ Terraform is required but not installed. Aborting." >&2; exit 1; }
command -v helm >/dev/null 2>&1 || { echo "❌ Helm is required but not installed. Aborting." >&2; exit 1; }
command -v python3 >/dev/null 2>&1 || { echo "❌ Python3 is required but not installed. Aborting." >&2; exit 1; }

echo "✅ Prerequisites check passed"

# Setup Python virtual environment
echo "🐍 Setting up Python virtual environment..."
python3 -m venv venv
source venv/bin/activate

# Install Python dependencies
echo "📦 Installing Python dependencies..."
if [ -f "apps/cli/requirements.txt" ]; then
    pip install -r apps/cli/requirements.txt
fi

if [ -f "apps/web/requirements.txt" ]; then
    pip install -r apps/web/requirements.txt
fi

# Initialize Terraform
echo "🏗️  Initializing Terraform..."
cd infra/environments/dev
terraform init
cd ../../..

echo "✅ Setup complete!"
echo ""
echo "Next steps:"
echo "  1. Configure your AWS credentials"
echo "  2. Update infra/environments/dev/main.tf with your settings"
echo "  3. Run: make infra-plan-dev"
echo "  4. Run: make infra-apply-dev"
