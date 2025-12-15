# Architecture Memory

Overview:

- Vault (self-hosted) is used as the production secrets store.
- AppRole authentication is used by the app at boot to fetch secrets from KV v2.
- Systemd drop-ins are used on the VPS to inject short-lived AppRole IDs (role_id/secret_id) into the service environment.
- GitHub Actions copies the systemd drop-in (or writes it) to the VPS via SSH and restarts the service as part of the deploy job.
- Local testing uses a Docker mock VPS to simulate scp/ssh and systemctl calls.

Components:

- `vault/`: operator-grade Vault templates and init script.
- `node/`: Node helper to login AppRole and fetch KV v2 secrets.
- `demo/`: minimal TypeScript Express app for demonstration.
- `docker/mock-deploy/`: Docker-based mock VPS to test deploy flow locally.
- `.github/workflows/ops-deploy-standard.yml`: sample CI workflow with build and deploy steps.
