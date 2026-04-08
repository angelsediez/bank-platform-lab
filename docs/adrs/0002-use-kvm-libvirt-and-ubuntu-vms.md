# ADR 0002: Use KVM/libvirt on Fedora with Ubuntu Server 24.04 guest VMs

- Status: Accepted
- Date: YYYY-MM-DD

## Context

The project needs a realistic but maintainable homelab environment that can support:

- infrastructure provisioning practice
- multi-node Kubernetes operations
- GitOps workflows
- persistent workloads
- observability and recovery drills

The host system is a Fedora 43 workstation with 32 GB RAM and local storage available for virtual machine disks and backups.

A key design requirement is to keep the host clean and avoid installing the platform stack directly on the Fedora workstation.

## Decision

Use Fedora 43 as the host operating system with:

- KVM/QEMU
- libvirt
- virt-manager
- related virtualization tooling

Run all platform components inside Ubuntu Server 24.04 LTS virtual machines.

The VM topology is:

- `vm-mgmt`
- `vm-k3s-server`
- `vm-k3s-worker-1`
- `vm-k3s-worker-2`

## Consequences

### Positive

- Keeps the Fedora host focused on virtualization only.
- Improves isolation between the host and the platform under test.
- Makes the homelab more reproducible and easier to rebuild.
- Provides realistic boundaries between infrastructure, management, and cluster layers.
- Uses a guest operating system with a stable lifecycle and broad compatibility.

### Negative

- Adds virtualization overhead.
- Requires explicit VM provisioning, storage planning, and guest bootstrap steps.
- Introduces another operational layer to troubleshoot compared with running tools directly on the host.

## Alternatives Considered

### Run the platform directly on the Fedora host

This was rejected because it would blur the boundary between the workstation and the lab environment and make the project harder to rebuild cleanly.

### Use container-based local clusters only

This was rejected because it reduces the infrastructure learning surface and does not provide the same separation of roles as a VM-based topology.

### Use a different guest operating system

This was considered, but Ubuntu Server 24.04 LTS was selected because it provides a stable and practical base for the cluster nodes and management VM.

## Notes

This decision supports the broader goal of treating the homelab as a small but disciplined platform environment rather than a convenience-only local test setup.
