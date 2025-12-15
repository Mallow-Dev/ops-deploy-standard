# Progress Memory

## Current state (date: 2025-12-15)

- Vault operator scripts created: `vault.hcl`, `vault.service`, `init-and-approle.sh`.
- Node AppRole helper added: `node/vault-client.ts` and `node/validate-vault.js`.
- Demo app added and builds successfully: `demo/`
- Docker mock deploy added: `docker/mock-deploy/` with `run-demo.sh` and `mock-systemctl.sh`.
- Demo private key removed from repo and key generator added: `scripts/generate-demo-key.sh`.
- `run-demo.sh` updated to use locally generated keys and fallback to repo public key (for demos).
- Secret-scan pre-commit hook added: `.githooks/pre-commit` and `scripts/secret-scan.sh`.
- Vitest unit tests added and passing: `test/vault-client.test.ts`, `test/demo.test.ts`.
- Tests run clean locally; small compatibility fixes applied to `node/vault-client.ts` and `demo/src/index.ts` to support testing.

## Remaining (recommended)

- Add `Makefile` for convenience targets.
- Add `SECURITY.md`, `.gitattributes`, `.editorconfig`, `.env.example` and expand README.
- Consider creating a standalone repo and publishing the package as an internal tool.
