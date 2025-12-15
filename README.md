# Ops Deploy Standard

Standardised deployment utilities: Vault operator scripts, a tiny demo app, a Node Vault helper, and a mock deploy environment for testing SSH-based deployments.

Structure

- `vault/` - Vault operator scripts and systemd service template
- `node/` - Node helper for AppRole login and KV v2 reads
- `demo/` - Minimal TypeScript demo app (Express) with build/start
- `docker/` - Docker mock deploy environment and demo runner
- `.github/workflows/` - Example CI + deploy workflow
- `scripts/` - helper scripts such as `generate-demo-key.sh`

Usage (quickstart)

1. Generate a local demo key (private key is stored under `$XDG_DATA_HOME/ops-deploy-standard` and not committed):

```
./scripts/generate-demo-key.sh
```

2. Run the demo mock deploy (builds mock VPS container and performs a simulated deploy):

```
make demo
```

3. Build the demo app:

```
make build-demo
```

Security notes

- The repository does not contain production secrets. Demo private keys are generated locally and should never be committed.
- Before running `vault/init-and-approle.sh` in production, ensure TLS is configured in `vault/vault.hcl` and the Vault operator follows secure key handling processes.

Operator notes

- Initialize Vault and create an AppRole using `vault/init-and-approle.sh`.
- Provide TLS certs and configure `vault.hcl` before running Vault in production.

