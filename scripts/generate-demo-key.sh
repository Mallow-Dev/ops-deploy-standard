#!/usr/bin/env bash
set -euo pipefail

# Generates a local demo SSH keypair for ops-deploy-standard and prints the public key.
# The private key is written under $XDG_DATA_HOME or ~/.local/share and NOT committed.

OUT_DIR=${XDG_DATA_HOME:-$HOME/.local/share}/ops-deploy-standard
mkdir -p "$OUT_DIR"
KEY_PATH="$OUT_DIR/ops_deploy_demo_key"

if [ -f "$KEY_PATH" ]; then
  echo "Key already exists at $KEY_PATH"
  echo "Public key:"
  cat "$KEY_PATH.pub"
  exit 0
fi

echo "Generating ed25519 keypair at $KEY_PATH"
ssh-keygen -t ed25519 -f "$KEY_PATH" -N "" -q
chmod 600 "$KEY_PATH"

echo "Generated demo key. Public key:"
cat "$KEY_PATH.pub"
echo "Private key location: $KEY_PATH (do not commit this file)"
