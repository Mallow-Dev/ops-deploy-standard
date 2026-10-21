# Contributing

Changes in this repository must remain implementation/tooling changes that conform to `Mallow-Dev/org-governance` and `Mallow-Dev/org-engineering-standards`. If a contribution changes applicability, exception policy or a normative engineering requirement, propose that change in the corresponding authority repository instead of defining it here.

Guidelines:

- Fork or clone the repo and open a branch for your change.
- Run `make demo` to validate changes against the mock deploy environment.
- Add unit tests for any logic and run `npm test` in subprojects where applicable.
- Use conventional commits for commit messages (feat/fix/docs/chore).

Pull Request:

- Provide a clear description, testing steps, and any environment assumptions.
