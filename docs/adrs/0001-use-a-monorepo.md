# ADR 0001: Use a monorepo for the platform project

- Status: Accepted
- Date: YYYY-MM-DD

## Context

This project needs to show a complete and navigable story that includes architecture, infrastructure, GitOps, platform services, the demo workload, and operational documentation.

Because the project is intended to evolve in phases, the repository structure also needs to support traceability between technical decisions, implementation artifacts, validation results, and operational notes.

## Decision

Use a single GitHub repository for all project assets.

The repository will contain:

- architecture documentation
- ADRs
- infrastructure code
- GitOps structure
- platform configuration
- application code
- runbooks
- troubleshooting guides
- evidence artifacts

## Consequences

### Positive

- Better traceability between decisions, code, and evidence.
- Stronger reproducibility story.
- Simpler documentation model with one central README.
- Lower coordination overhead for a single-operator project.

### Negative

- The repository will grow in size over time.
- Strong naming and folder discipline are required.
- CI workflows must remain scoped and intentional to avoid unnecessary complexity.

## Alternatives Considered

### Split application and platform into separate repositories

This was rejected because it would fragment the story of the project and make review harder.

### Use a dedicated documentation repository

This was rejected because the operational documentation needs to live close to the implementation artifacts and evidence.

## Notes

The monorepo decision is based on clarity, maintainability, and project coherence rather than scale.

If the banking API ever becomes a separate reusable project in the future, it can be extracted later without changing the current rationale.
