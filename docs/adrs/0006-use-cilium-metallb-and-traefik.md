# ADR 0006: Use Cilium, MetalLB, and Traefik as the networking stack

- Status: Accepted
- Date: YYYY-MM-DD

## Context

The project needs a networking stack that supports:

- a Kubernetes CNI with real operational value
- visibility into cluster traffic
- service exposure in a VM-based homelab
- ingress routing for platform and application endpoints

Because this project runs on a local KVM/libvirt environment rather than on a cloud provider, it does not have access to a managed LoadBalancer implementation.

The networking design also needs to stay understandable and maintainable for a single operator.

## Decision

Use the following networking stack:

- Cilium as the primary CNI
- Hubble for network visibility
- MetalLB for LoadBalancer-style service exposure
- Traefik as the ingress controller

This combination is intended to cover cluster networking, service exposure, traffic visibility, and ingress routing without introducing unnecessary extra layers.

## Consequences

### Positive

- Cilium provides a modern CNI with strong visibility and policy capabilities.
- Hubble improves observability and troubleshooting for network flows.
- MetalLB provides a practical LoadBalancer solution for a bare-metal or VM-based lab.
- Traefik gives the project a clear ingress layer for internal and application-facing routes.
- The stack remains understandable without introducing a full service mesh.

### Negative

- This introduces several components that must work together correctly.
- Bare-metal style service exposure requires more manual planning than cloud-managed networking.
- Network troubleshooting may involve multiple layers: CNI, service exposure, and ingress.

## Alternatives Considered

### Use the default lightweight networking path only

This was rejected because the project needs more networking depth and visibility than the most minimal cluster defaults provide.

### Use ingress only without MetalLB

This was rejected because the lab still needs a practical way to expose services through LoadBalancer-style addresses.

### Use a service mesh in the initial version

This was rejected because it would add complexity without enough return for the first version of the project.

## Notes

This decision is intentionally scoped.

The project uses a serious networking stack, but it does not try to become a networking demo project. The goal is to practice useful patterns for routing, visibility, and service exposure under realistic homelab constraints.
