# ADR 0003: Use a single-server K3s cluster with two worker nodes

- Status: Accepted
- Date: YYYY-MM-DD

## Context

The project needs a Kubernetes environment that is realistic enough to support:

- multi-node scheduling
- platform services
- persistent workloads
- GitOps workflows
- observability
- failure and recovery practice

At the same time, the homelab is constrained by a single workstation with 32 GB RAM and a finite CPU and storage budget.

A full control plane HA design would increase complexity and resource consumption significantly.

## Decision

Use K3s as the Kubernetes distribution with:

- 1 server node
- 2 worker nodes

The selected topology is:

- `vm-k3s-server`
- `vm-k3s-worker-1`
- `vm-k3s-worker-2`

This cluster shape is intentionally chosen to balance realism, operational value, and hardware limits.

## Consequences

### Positive

- Provides a true multi-node cluster rather than a single-node convenience setup.
- Allows workloads and platform services to be distributed across worker nodes.
- Keeps the control plane simple enough for one operator to manage.
- Fits the available hardware budget better than a full HA control plane.
- Leaves enough room for observability, storage, and PostgreSQL without overcommitting the host.

### Negative

- The control plane is still a single point of failure.
- This does not model production-grade HA for the Kubernetes API server.
- Some resilience lessons are limited compared with a three-server control plane design.

## Alternatives Considered

### Single-node Kubernetes cluster

This was rejected because it reduces the operational learning surface too much and does not provide realistic scheduling or worker separation.

### Full HA K3s control plane

This was rejected for the initial version because it would consume more resources, introduce more complexity, and provide less return for this hardware budget.

### kubeadm-based cluster

This was considered, but K3s was selected because it offers a smaller operational footprint and a more practical fit for this homelab.

## Notes

This decision does not claim production-grade control plane HA.

It deliberately favors a disciplined, resource-aware learning environment that still exposes meaningful Kubernetes operations and platform behavior.
