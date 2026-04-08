# Evidence Plan

## Purpose

This document defines the evidence that must be captured as the project progresses.

The goal is to make the repository reviewable, credible, and useful for validation, troubleshooting, and iterative learning.

---

## Evidence Categories

### 1. Infrastructure evidence
- OpenTofu plan output
- OpenTofu apply summary
- VM inventory screenshot
- SSH reachability validation

### 2. Cluster bootstrap evidence
- `kubectl get nodes -o wide`
- K3s service health
- Cilium and Hubble status
- Base namespaces present

### 3. GitOps evidence
- Argo CD applications healthy and synced
- Root application tree
- Drift correction example
- Sync failure and recovery example

### 4. Networking evidence
- MetalLB external IP assignment
- Traefik ingress routing
- Hubble flow visibility
- NetworkPolicy validation

### 5. Storage evidence
- Longhorn volume and replica status
- PVC binding
- Node and disk allocation screenshot

### 6. Observability evidence
- Grafana cluster dashboard
- Grafana bank API dashboard
- Loki logs for a transfer request
- Tempo trace for a transfer request
- Fired and resolved alert example

### 7. PostgreSQL and application evidence
- API health and readiness checks
- Migration job success
- PostgreSQL connectivity validation
- Account creation and transfer flow

### 8. Recovery evidence
- Logical backup artifact
- Restore drill notes
- Restored data verification
- Recovery validation commands

---

## File Naming Convention

```text
evidence/screenshots/phase-XX-topic-description.png
evidence/validation-results/phase-XX-command-output.txt
evidence/drills/phase-XX-drill-name.md
```

### Minimum Screenshot Set

| File | Description |
| :--- | :--- |
| `phase-02-libvirt-vms-running.png` | VM inventory after provisioning |
| `phase-03-k3s-nodes-ready.png` | K3s nodes in Ready state |
| `phase-04-argocd-root-app-synced.png` | Argo CD root application healthy |
| `phase-05-longhorn-volumes-healthy.png` | Longhorn volume health |
| `phase-06-grafana-cluster-dashboard.png` | Cluster observability dashboard |
| `phase-06-grafana-bank-api-dashboard.png` | Application observability dashboard |
| `phase-08-bank-api-transfer-trace.png` | Trace for a transfer request |
| `phase-09-postgres-restore-validation.png` | Restore drill validation |

---

## Rules

* **Capture evidence only after validation succeeds.**
* **Prefer screenshots that show operational state**, not installation pages.
* Keep screenshots **clean and named consistently**.
* **Save command outputs** for anything that may be useful during troubleshooting, rebuilds, or later validation.
* Do **not** use screenshots as a substitute for runbooks or validation notes.

---

## Notes

The evidence collected in this repository should help answer practical questions such as:

* Was the environment actually provisioned?
* Was the cluster healthy?
* Did GitOps reconciliation work?
* Was storage functional?
* Was observability useful beyond dashboards?
* Was PostgreSQL backed up and restored successfully?
