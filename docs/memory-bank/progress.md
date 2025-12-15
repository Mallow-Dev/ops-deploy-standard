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

### Coverage (date: 2025-12-15)

- **All files:** Statements 84%, Branches 55.55%, Functions 83.33%, Lines 95.23%
- **node/vault-client.ts:** Statements 88.88%, Branches 58.33%, Functions 100%, Lines 100% (uncovered lines: 4,14,25-34)
- **demo/src/index.ts:** Statements 71.42%, Branches 50%, Functions 50%, Lines 83.33% (uncovered: line 11)

Notes: Branch coverage is low because error and alternative branches were not exercised by current tests. Recommend adding negative/error case tests for `node/vault-client.ts` and a test for the demo's server-start conditional.

## Remaining (recommended)

- Add `Makefile` for convenience targets.
- Add `SECURITY.md`, `.gitattributes`, `.editorconfig`, `.env.example` and expand README.
- Consider creating a standalone repo and publishing the package as an internal tool.
