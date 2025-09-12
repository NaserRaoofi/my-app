.PHONY: help infra-dev infra-staging infra-prod k8s-deploy-dev k8s-deploy-prod app-run

help: ## Show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

# 🔹 Infrastructure Commands
infra-init: ## Initialize Terraform backend
	cd infra && terraform init

infra-plan-dev: ## Plan infrastructure for dev environment
	cd infra/environments/dev && terraform init && terraform plan

infra-apply-dev: ## Apply infrastructure for dev environment
	cd infra/environments/dev && terraform init && terraform apply

infra-plan-staging: ## Plan infrastructure for staging environment
	cd infra/environments/staging && terraform init && terraform plan

infra-apply-staging: ## Apply infrastructure for staging environment
	cd infra/environments/staging && terraform init && terraform apply

infra-plan-prod: ## Plan infrastructure for prod environment
	cd infra/environments/prod && terraform init && terraform plan

infra-apply-prod: ## Apply infrastructure for prod environment
	cd infra/environments/prod && terraform init && terraform apply

# 🔹 Kubernetes Commands
k8s-lint: ## Lint Helm charts
	helm lint k8s/charts/app-chart
	helm lint k8s/charts/monitoring

k8s-deploy-dev: ## Deploy to dev environment
	helm upgrade --install app-dev k8s/charts/app-chart -f k8s/values/dev/values.yaml

k8s-deploy-prod: ## Deploy to prod environment
	helm upgrade --install app-prod k8s/charts/app-chart -f k8s/values/prod/values.yaml

# 🔹 Application Commands
app-install: ## Install app dependencies
	cd apps/cli && pip install -r requirements.txt
	cd apps/web && pip install -r requirements.txt

app-test: ## Run app tests
	cd apps/web && python -m pytest tests/

app-run: ## Run web application locally
	cd apps/web && python src/main.py

# 🔹 Setup Commands
setup: ## Initial project setup
	./scripts/setup.sh

clean: ## Clean temporary files
	find . -name "*.pyc" -delete
	find . -name "__pycache__" -delete
	cd infra && find . -name ".terraform" -exec rm -rf {} +
