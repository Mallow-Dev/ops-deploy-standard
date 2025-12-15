#!/usr/bin/env bash
set -euo pipefail

# Initialize Vault (once) and create a KV v2 path and an AppRole with minimal policy
# Usage: ./init-and-approle.sh

VAULT_ADDR=${VAULT_ADDR:-http://127.0.0.1:8200}

if ! command -v vault >/dev/null 2>&1; then
  echo "vault CLI required. Install it first."
  exit 1
fi

if [ -f ./vault.init.json ]; then
  echo "vault already initialized (vault.init.json present)."
else
  echo "Initializing vault..."
  vault operator init -format=json > vault.init.json
  echo "Wrote vault.init.json - store this securely!"
fi

ROOT_TOKEN=$(jq -r .root_token vault.init.json)
export VAULT_TOKEN=$ROOT_TOKEN

echo "Enabling kv v2 at secret/"
vault secrets enable -path=secret kv-v2 || true

cat > policy.hcl <<'EOF'
path "secret/data/*" {
  capabilities = ["read", "list"]
}
EOF

vault policy write secret-read policy.hcl

echo "Creating AppRole 'deploy-role'"
vault write auth/approle/role/deploy-role token_ttl=1h token_max_ttl=4h policies=secret-read

ROLE_ID=$(vault read -format=json auth/approle/role/deploy-role/role-id | jq -r .data.role_id)
SECRET_ID=$(vault write -format=json auth/approle/role/deploy-role/secret-id -field=secret_id)

cat > approle.out <<EOF
ROLE_ID=${ROLE_ID}
SECRET_ID=${SECRET_ID}
ROOT_TOKEN=${ROOT_TOKEN}
EOF

echo "Wrote approle.out with ROLE_ID and SECRET_ID. Keep secret_id safe."
