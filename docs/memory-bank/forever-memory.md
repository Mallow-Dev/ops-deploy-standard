# Forever Memory (User Profile)

This file records user-level, long-lived rules that should be applied across projects and kept in the personal/organization memory bank.

Rule: ALWAYS USE CURRENT PACKAGE VERSIONS

- Rationale: Avoid accumulating technical debt that leads to risky, large-scale refactors later. Small, frequent upgrades reduce security exposure and make reviewable incremental changes.
- Enforcement: Enable dependency automation (Dependabot or Renovate) for patch/minor updates; treat major upgrades as planned work (branch + tests + staged rollout).
- Exceptions: Eligibility, approval, scope, expiry, and the authoritative exception record are defined exclusively by `Mallow-Dev/org-governance`.
  This repository may link to an approved governance exception but must not define separate local exception criteria or authority.

Operational guidance:
- Weekly or bi-weekly review of dependency update PRs.
- CI gates: run `npm ci && npm test -- --coverage` on update PRs.
- Security: Prioritise security fixes; apply them immediately.
