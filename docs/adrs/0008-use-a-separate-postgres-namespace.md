# ADR 0008: Deploy PostgreSQL in a separate namespace from the banking API

- Status: Accepted
- Date: YYYY-MM-DD

## Context

The project includes a small Go banking API and a PostgreSQL database.

Even though both components belong to the same lab, they do not serve the same operational purpose. The application is a workload that generates stateful traffic and telemetry, while PostgreSQL is a persistence layer that requires its own backup, restore, security, and troubleshooting boundaries.

The project also aims to make GitOps structure, policy boundaries, and operational documentation easier to understand.

## Decision

Deploy PostgreSQL in the `postgres` namespace and the banking API in the `bank` namespace.

The two components will communicate explicitly through Kubernetes services and configuration, but they will not share the same namespace.

## Consequences

### Positive

- Makes the boundary between application and database responsibilities clearer.
- Improves GitOps readability by separating workload layers.
- Supports cleaner NetworkPolicy and access control boundaries.
- Makes backup and restore documentation easier to scope.
- Helps troubleshooting by isolating stateful database concerns from application concerns.

### Negative

- Adds one more namespace and some additional configuration overhead.
- Requires more explicit service references and access rules.
- Slightly increases setup complexity compared with putting everything in one namespace.

## Alternatives Considered

### Deploy PostgreSQL in the same namespace as the banking API

This was rejected because it would blur operational boundaries and make documentation, policy design, and troubleshooting less clear.

### Use a shared namespace for all workloads

This was rejected because the project benefits from clearer separation between stateful infrastructure services and application workloads.

## Notes

This decision is about clarity and operational separation, not about pretending the project is larger than it is.

Even in a small homelab, separating database and application namespaces creates better habits for GitOps structure, backup scope, and troubleshooting.
