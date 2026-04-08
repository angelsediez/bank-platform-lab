# ADR 0005: Use SOPS, age, and KSOPS for GitOps-compatible secret management

- Status: Accepted
- Date: YYYY-MM-DD

## Context

The project needs a secret management approach that works with GitOps while keeping sensitive values out of plain-text Git history.

The solution must support:

- encrypted secrets stored in Git
- compatibility with Argo CD
- a manageable operational model for a single-operator homelab
- low additional platform overhead

The project does not need a full enterprise secret platform for the initial version, but it does need a disciplined and practical approach to handling credentials.

## Decision

Use the following components for secret management:

- SOPS
- age
- KSOPS
- Argo CD repo-server CMP integration

The workflow is:

- secrets are authored locally on the management VM
- they are encrypted with SOPS using age recipients
- only encrypted versions are committed to Git
- Argo CD decrypts them at render time through KSOPS

The private age key is not stored in Git and will be mounted into Argo CD during bootstrap.

## Consequences

### Positive

- Keeps secrets encrypted at rest in Git.
- Fits naturally into the GitOps delivery model.
- Avoids introducing a separate secret platform too early.
- Keeps the workflow understandable for one operator.
- Makes the boundary between encrypted source and rendered runtime clear.

### Negative

- Requires careful handling of the private age key.
- Losing the private key would block secret recovery from the encrypted files.
- Adds a custom integration step to the Argo CD repo-server.
- Secret rotation still needs documented operator discipline.

## Alternatives Considered

### Store Kubernetes Secrets in plain YAML

This was rejected because it is not acceptable for a serious public repository.

### Use Sealed Secrets

This was considered, but rejected in favor of SOPS because SOPS keeps the encrypted source portable and editor-friendly outside the cluster.

### Use Vault or External Secrets Operator

This was rejected for the initial version because it would add significant platform complexity and operational overhead beyond what the project currently needs.

## Notes

This decision favors a practical and disciplined homelab workflow rather than a heavyweight secret-management stack.

The private age key must be backed up securely outside Git, and future runbooks should document rotation and recovery procedures explicitly.
