# Homelab Topology

## Purpose

This document defines the physical and virtual topology for `bank-platform-lab`, including host constraints, VM sizing, network layout, storage assumptions, and role separation.

## Host Specification

| Component | Value |
|---|---|
| CPU | AMD Ryzen Threadripper 1950X |
| Memory | 32 GB |
| GPU | GTX 1080 Ti |
| Host OS | Fedora 43 KDE |
| Hypervisor | KVM/QEMU |
| Virtualization management | libvirt, virt-manager |
| VM storage | 1 TB SSD |
| Backup and evidence storage | 6 TB HDD |

## Virtual Machine Inventory

| VM | vCPU | RAM | Disk | OS | Role |
|---|---:|---:|---:|---|---|
| `vm-mgmt` | 2 | 4 GB | 50 GB | Ubuntu Server 24.04 LTS | IaC, kubectl, Helm, SOPS, scripts |
| `vm-k3s-server` | 4 | 6 GB | 60 GB | Ubuntu Server 24.04 LTS | K3s server |
| `vm-k3s-worker-1` | 4 | 8 GB | 80 GB | Ubuntu Server 24.04 LTS | workloads |
| `vm-k3s-worker-2` | 4 | 8 GB | 80 GB | Ubuntu Server 24.04 LTS | workloads |

## Resource Summary

| Resource | Total assigned |
|---|---:|
| vCPU | 14 |
| RAM | 26 GB |
| Disk | 270 GB |

The remaining headroom is reserved for the Fedora host and virtualization overhead.

## Network Layout

### Primary lab network

- Type: libvirt NAT
- CIDR: `192.168.150.0/24`

### Reserved IP addresses

| Node | IP |
|---|---|
| `vm-mgmt` | `192.168.150.10` |
| `vm-k3s-server` | `192.168.150.11` |
| `vm-k3s-worker-1` | `192.168.150.12` |
| `vm-k3s-worker-2` | `192.168.150.13` |

### MetalLB pool

- `192.168.150.240-192.168.150.250`

## Role Separation

### Fedora host

The Fedora host is kept intentionally clean and only runs virtualization tooling and local project files.

### Management VM

The management node acts as the operational entry point for:

- OpenTofu execution
- cluster bootstrap commands
- `kubectl` and Helm access
- SOPS and age operations
- validation scripts

### K3s server VM

The server node provides the cluster control plane.

### Worker VMs

The worker nodes host platform services and workloads.

## Cluster Shape

The cluster is intentionally small but operationally meaningful:

- 1 control plane node
- 2 worker nodes

This topology provides a better learning surface than a single-node cluster while staying inside the available hardware budget.

## Storage Layout

### SSD

The SSD stores active VM disks and the running state of the homelab.

### HDD

The HDD stores:

- backup exports
- screenshots
- drill notes
- validation outputs
- VM exports and large artifacts

## Planned Persistent Workloads

The cluster is expected to run these persistent services:

- Longhorn
- PostgreSQL
- Prometheus
- Loki
- Tempo
- Grafana

These components are intentionally kept small and resource-conscious.

## Operational Constraints

This homelab is not designed to simulate a full production platform.

It is designed to show:

- practical cluster operations
- repeatable provisioning
- platform composition
- stateful workloads
- observability
- recovery procedures

## Risks

The main operational risks in this topology are:

- limited RAM headroom
- storage replication overhead
- rebuild pressure on Longhorn
- oversized retention settings
- unnecessary tool sprawl

## Validation Targets

The topology is considered valid when:

- all VMs are reachable
- node roles are clearly separated
- the cluster remains stable under the intended platform load
- persistent services fit within the memory budget
- evidence collection remains manageable
