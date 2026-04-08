# Skills Demonstrated

This document maps platform engineering capabilities to repository evidence.

## Evidence Map

| Capability | Repository evidence | Status |
|---|---|---|
| Architecture design | `docs/architecture.md`, `docs/homelab-topology.md`, `docs/adrs/` | Implemented |
| Technical decision documentation | `docs/adrs/` | Implemented |
| Repository design for platform projects | repository layout, `README.md`, `docs/` structure | Implemented |
| Infrastructure as Code with OpenTofu | `infrastructure/tofu/` | Planned |
| Cloud-init guest bootstrap | `infrastructure/cloud-init/` | Planned |
| KVM/libvirt homelab infrastructure design | `docs/homelab-topology.md`, `infrastructure/` | Designed |
| Kubernetes cluster bootstrap | `scripts/cluster/`, future phase evidence | Planned |
| GitOps delivery with Argo CD | `gitops/` | Planned |
| Kubernetes networking design | `platform/networking/`, ADR 0006 | Designed |
| Persistent storage strategy | `platform/storage/`, ADR 0007 | Designed |
| Secret management for GitOps | ADR 0005, `platform/security/sops/` | Designed |
| Observability architecture | `platform/observability/`, `docs/architecture.md` | Designed |
| Security baseline design | `platform/security/`, ADRs, future runbooks | Designed |
| Stateful workload operations | `gitops/workloads/postgres/`, future runbooks | Planned |
| Application packaging and delivery | `app/bank-api/` | Planned |
| Backup and restore workflow | `docs/runbooks/postgres-backup-restore.md` | Planned |
| Troubleshooting documentation | `docs/troubleshooting/` | Planned |
| Evidence collection and validation planning | `evidence/`, `docs/evidence-plan.md` | Implemented |

## Notes

The repository intentionally distinguishes between:

- implemented work
- designed work
- planned work

This prevents the project from overstating progress while still showing a coherent engineering roadmap.

## Interpretation

The purpose of this document is not to exaggerate the current state of the repository.

Its purpose is to show:

- what has already been completed
- what has already been designed
- what is intentionally planned for later phases

This helps keep the project technically honest while still making its direction clear.
