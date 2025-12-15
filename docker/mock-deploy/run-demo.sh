#!/usr/bin/env bash
set -euo pipefail
ROOT=$(cd "$(dirname "$0")/.." && pwd)
cd "$ROOT/mock-deploy"

echo "Building mock VPS container..."
docker compose build --no-cache
docker compose up -d

echo "Using bundled demo SSH keypair (no runtime generation)."
# The demo includes a pre-generated ed25519 keypair for quick local testing.
# In production, NEVER commit private keys into source control — this is only for local demos.
DEMO_KEY_DIR=$(pwd)
TEMPKEY="$DEMO_KEY_DIR/ssh_demo_key"
#!/usr/bin/env bash
set -euo pipefail
ROOT=$(cd "$(dirname "$0")/.." && pwd)
cd "$ROOT/mock-deploy"

# Build and run the mock VPS container
echo "Building mock VPS container..."
docker compose build --no-cache
docker compose up -d

# Determine public key to inject into the mock VPS
LOCAL_KEY_DIR=${XDG_DATA_HOME:-$HOME/.local/share}/ops-deploy-standard
LOCAL_KEY_PATH="$LOCAL_KEY_DIR/ops_deploy_demo_key"
REPO_PUB="$ROOT/mock-deploy/ssh_demo_key.pub"

if [ -f "$LOCAL_KEY_PATH.pub" ]; then
	PUBKEY=$(cat "$LOCAL_KEY_PATH.pub")
	echo "Using local generated key: $LOCAL_KEY_PATH"
elif [ -f "$REPO_PUB" ]; then
	PUBKEY=$(cat "$REPO_PUB")
	echo "Using repo fallback public key (for demos only): $REPO_PUB"
else
	echo "No public key found. Run:"
	echo "  $ROOT/../scripts/generate-demo-key.sh"
	echo "or create a key at $LOCAL_KEY_PATH"
	exit 1
fi

echo "--- Demo public key (copy to server authorized_keys if needed) ---"
echo "$PUBKEY"
echo "--- End demo public key ---"

# Inject public key into mock VPS and perform mock deploy steps
CONTAINER=$(docker compose ps -q mock-vps)
docker exec -i ${CONTAINER} bash -c "mkdir -p /home/deploy/.ssh && echo '${PUBKEY}' >> /home/deploy/.ssh/authorized_keys && chown -R deploy:deploy /home/deploy/.ssh"

echo "Simulating deploy: scp drop-in and restart via ssh (mock)"
echo "(Using docker exec to simulate)"
docker cp ../../vault/vault.service ${CONTAINER}:/tmp/vault.service
docker exec -i ${CONTAINER} sudo mv /tmp/vault.service /etc/systemd/system/vault.service
docker exec -i ${CONTAINER} sudo /usr/local/bin/mock-systemctl restart vault

echo "Demo deploy completed."
