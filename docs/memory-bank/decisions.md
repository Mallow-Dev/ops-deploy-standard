# Decisions Memory

- Use HashiCorp Vault (self-hosted) with KV v2 for secrets.
- Use AppRole for machine authentication and minimal read-only policies.
- Fail-fast env validation in apps; do not allow insecure default secrets in code.
- Use systemd drop-ins to inject short-lived AppRole IDs into target servers during deploy.
- Prefer Ed25519 keys for demo automation to avoid entropy blocking and for modern cryptography.

- **Dependency Decision:** Adopt an organizational rule to keep dependencies on current versions. Prefer frequent small updates (patch/minor) via automation; handle major upgrades with dedicated branches, tests, and rollouts.
