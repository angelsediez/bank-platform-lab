# ADR 0007: Use Longhorn for persistent storage

- Status: Accepted
- Date: YYYY-MM-DD

## Context

The project needs a persistent storage layer for stateful workloads such as:

- PostgreSQL
- Prometheus
- Grafana
- Loki
- Tempo

The storage design must support:

- Kubernetes-native persistence
- practical learning value for stateful workloads
- visibility into volume health and replicas
- backup and recovery practice
- operation inside a small multi-node homelab

Because the cluster runs on virtual machines without a managed cloud storage backend, the project needs a storage solution that can be operated directly inside the Kubernetes environment.

## Decision

Use Longhorn as the persistent storage platform for the initial version of the project.

The storage model will follow these assumptions:

- Longhorn provides the default persistent storage layer for stateful components
- replica count will be kept conservative
- persistence will be used with discipline and limited retention settings
- the storage design will prioritize operational learning over maximum scale

## Consequences

### Positive

- Provides a Kubernetes-native storage layer suitable for stateful workloads.
- Creates a realistic learning surface for volume lifecycle management.
- Supports practice with storage health checks, replica awareness, and persistence troubleshooting.
- Fits the broader project goal of learning how to operate stateful services, not just deploy stateless workloads.
- Gives the platform a stronger recovery and backup story than ephemeral storage would allow.

### Negative

- Adds storage overhead to an already resource-constrained lab.
- Requires careful capacity management and retention discipline.
- Replica rebuilds and storage recovery can generate noticeable IO pressure.
- Increases operational complexity compared with local-path-only storage.

## Alternatives Considered

### Use only local ephemeral or minimal host-path style storage

This was rejected because it would reduce the learning surface too much and weaken the stateful workload and recovery aspects of the project.

### Use a lighter local storage approach for everything

This was considered, but rejected as the primary design because the project needs a more serious persistence model for PostgreSQL and observability components.

### Avoid persistent observability altogether

This was rejected because short-lived or fully ephemeral observability would reduce the practical value of debugging and recovery workflows.

## Notes

This decision is intentionally pragmatic.

Longhorn is not being used here to simulate a large enterprise storage platform. It is being used to practice the operational realities of persistent workloads in Kubernetes under realistic homelab constraints.

Future implementation should keep storage sizing, retention, and replica count conservative.
