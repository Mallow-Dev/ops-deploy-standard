# Project Memory

## Name: Ops Deploy Standard

Purpose: A reusable deployment standard containing Vault operator scripts, a Node AppRole helper, a tiny TypeScript demo app, a mock SSH-based deploy environment (Docker), and a sample GitHub Actions workflow. Intended to be copied or used as a submodule across projects.

## Scope

- Provide operator-ready Vault templates and AppRole initialization.
- Provide a simple Node helper to fetch KV v2 secrets via AppRole and load them into process.env.
- Provide a small demo app and local mock of SSH-based deploy workflows for testing and onboarding.
