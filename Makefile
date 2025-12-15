SHELL := /usr/bin/env bash
.PHONY: demo build-demo vault-init validate clean

demo: ## Generate demo key (if missing) and run the mock deploy
	./scripts/generate-demo-key.sh
	./docker/mock-deploy/run-demo.sh

build-demo: ## Build the TypeScript demo app
	cd demo && npm install && npm run build

vault-init: ## Operator-only: run the Vault init script (interactive confirmation)
	@echo "== Vault init (operator only) =="
	@read -p "This will initialize Vault and create an AppRole. Continue? (y/N) " ans; \
	if [ "$$ans" = "y" ]; then \
	  bash vault/init-and-approle.sh; \
	else \
	  echo "Aborted"; \
	fi

validate: ## Validate Vault connectivity using env VAULT_ROLE_ID/VAULT_SECRET_ID
	node node/validate-vault.js

clean: ## Tear down mock deploy containers
	cd docker/mock-deploy && docker compose down --rmi local || true
