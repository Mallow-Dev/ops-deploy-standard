# Forever Memory (User Profile)

This file records user-level, long-lived rules that should be applied across projects and kept in the personal/organization memory bank.

Rule: ALWAYS USE CURRENT PACKAGE VERSIONS

- Rationale: Avoid accumulating technical debt that leads to risky, large-scale refactors later. Small, frequent upgrades reduce security exposure and make reviewable incremental changes.
- Enforcement: Enable dependency automation (Dependabot or Renovate) for patch/minor updates; treat major upgrades as planned work (branch + tests + staged rollout).
- Exceptions: Only rare, documented reasons (e.g., pinned for compatibility with an in-house platform) may deviate.
  Exception approval and the authoritative exception record belong in `Mallow-Dev/org-governance`; this repository may link to the approved governance record but must not create a competing local exception authority.

Operational guidance:
- Weekly or bi-weekly review of dependency update PRs.
- CI gates: run `npm ci && npm test -- --coverage` on update PRs.
- Security: Prioritise security fixes; apply them immediately.
