# ADR 0004: Use Argo CD with a small imperative bootstrap and an app-of-apps model

- Status: Accepted
- Date: YYYY-MM-DD

## Context

The project needs a delivery model that supports:

- declarative cluster state
- repeatable platform composition
- separation between bootstrap and steady-state reconciliation
- visibility into platform and workload synchronization

At the same time, some initial components must exist before GitOps can reconcile the rest of the system. Examples include the Kubernetes cluster itself, the CNI, Argo CD, and the secret decryption integration used by Argo CD.

This creates a natural boundary between what must be bootstrapped imperatively and what should be reconciled declaratively from Git.

## Decision

Use Argo CD as the GitOps control plane.

Adopt this delivery pattern:

- perform a minimal imperative bootstrap for the required base components
- install a root Argo CD application
- use an app-of-apps structure to reconcile platform and workload applications from Git

The imperative bootstrap will be limited to the minimum required components:

- K3s base installation
- Cilium installation
- Argo CD installation
- KSOPS integration
- root Argo CD application

After that point, the rest of the platform and workloads will be reconciled by Argo CD.

## Consequences

### Positive

- Establishes a clear boundary between bootstrap concerns and declarative operations.
- Keeps day-2 changes inside Git rather than in ad hoc shell history.
- Improves visibility into sync status, drift, and reconciliation failures.
- Scales better than applying individual manifests manually.
- Supports a clean hierarchy for platform and workload components.

### Negative

- Requires an initial bootstrap path outside GitOps.
- Adds conceptual overhead compared with plain Helm or direct `kubectl apply`.
- App-of-apps can become messy if naming and folder discipline are weak.

## Alternatives Considered

### Use GitHub Actions as the deployment mechanism

This was rejected as the primary CD model because CI pipelines and GitOps controllers solve different problems. GitHub Actions remains useful for CI, but Argo CD is better suited for in-cluster declarative reconciliation.

### Use plain Helm from the management VM

This was rejected because it would make day-2 changes less visible and reduce drift management and reconciliation transparency.

### Reconcile everything manually without a root application

This was rejected because the project needs a structured delivery hierarchy rather than a collection of unrelated application definitions.

## Notes

The bootstrap is intentionally small and pragmatic.

This project does not attempt “GitOps from the first packet.”  
Instead, it uses a minimal bootstrap to establish the control plane that will then manage the rest of the cluster declaratively.
