# Standards Memory

Standards followed and recommendations:

- Keep secrets out of source control — provide generators or secret-store integrations.
- Use Zod (or similar) for runtime env validation in TypeScript projects.
- Use systemd for service management on VPS targets.
- Prefer modern crypto (Ed25519) for automation keys.
- CI uses GitHub Actions with repository secrets for CI-run secrets and deploy keys.
- Documentation: include `SECURITY.md` and `CONTRIBUTING.md` for operator/dev onboarding.
