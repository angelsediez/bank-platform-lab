# Architecture

## Purpose

This document describes the target architecture of `bank-platform-lab`, the reasoning behind the main technical decisions, and the boundaries between infrastructure, cluster bootstrap, GitOps, platform services, and workloads.

## Design Principles

This project follows these principles:

- prefer one clear path over multiple equivalent options
- optimize for reproducibility over convenience
- keep the application small and the platform serious
- avoid unnecessary tool sprawl
- document trade-offs honestly
- design for one operator, not for a large team
- keep every major component justifiable on 32 GB RAM

## System Overview

The platform is built on a Fedora host running KVM/QEMU and libvirt.  
Four Ubuntu Server virtual machines provide the management layer and the K3s cluster:

- `vm-mgmt`
- `vm-k3s-server`
- `vm-k3s-worker-1`
- `vm-k3s-worker-2`

The Kubernetes platform is built around:

- K3s
- Cilium + Hubble
- MetalLB
- Traefik
- cert-manager
- Argo CD
- Longhorn
- Prometheus
- Grafana
- Loki
- Tempo
- Alertmanager
- OpenTelemetry Collector

The demo workload is a small Go banking API backed by PostgreSQL.

## Architecture Layers

### Host Layer

The Fedora host is responsible only for virtualization and VM storage.  
It does not run the platform services directly.

### Management Layer

`vm-mgmt` acts as the administrative entry point for:

- OpenTofu execution
- cluster bootstrap commands
- `kubectl` and Helm access
- SOPS and age operations
- validation and helper scripts

### Cluster Layer

The Kubernetes environment uses:

- 1 K3s server node
- 2 K3s worker nodes

This is a deliberate trade-off between realism, operational depth, and hardware limits.

## Networking Design

The lab uses a libvirt NAT network as the default phase-1 topology.

### Base network
- libvirt NAT network: `192.168.150.0/24`

### Reserved VM addresses
- `vm-mgmt`: `192.168.150.10`
- `vm-k3s-server`: `192.168.150.11`
- `vm-k3s-worker-1`: `192.168.150.12`
- `vm-k3s-worker-2`: `192.168.150.13`

### Service exposure
- MetalLB address pool: `192.168.150.240-192.168.150.250`
- Traefik as ingress controller
- cert-manager for TLS automation

### Cluster networking
- Cilium as primary CNI
- Hubble for network visibility and troubleshooting

## GitOps Design

Argo CD is used as the delivery control plane.

### Bootstrap model

A small imperative bootstrap is accepted for the minimum required cluster state:

- K3s installation
- Cilium installation
- Argo CD installation
- KSOPS integration
- root Argo CD application

After that point, platform and workload resources are reconciled declaratively from Git.

## Secrets Design

The project uses:

- SOPS
- age
- KSOPS
- Argo CD repo-server CMP integration

Secrets are stored encrypted in Git and decrypted during Argo CD rendering.

## Storage Design

Longhorn is the selected storage layer for persistent workloads.

Initial assumptions:

- replica count: 2
- PostgreSQL persistence on Longhorn
- observability persistence kept small and controlled

## Observability Design

The observability stack includes:

- Prometheus
- Alertmanager
- Grafana
- Loki
- Tempo
- OpenTelemetry Collector
- Hubble

Initial retention targets:

- Prometheus: 7 days
- Loki: 3 days
- Tempo: 48 hours

## Security Baseline

The initial project baseline includes:

- RBAC
- Pod security hardening
- NetworkPolicy
- image and manifest scanning
- encrypted secrets in Git
- limited policy validation

## Backup and Recovery Design

The project recovery model combines:

- declarative cluster state in Git
- infrastructure definitions in OpenTofu
- logical PostgreSQL backups
- documented restore drills
- Longhorn persistence for stateful services

## Phase Mapping

### Phase 1
Repository skeleton and architecture documentation.

### Phase 2
Infrastructure provisioning with OpenTofu and cloud-init.

### Phase 3
K3s bootstrap and initial cluster validation.

### Phase 4
Argo CD bootstrap and GitOps root application.

### Phase 5
Core platform services and storage.

### Phase 6
Observability stack.

### Phase 7
Security controls.

### Phase 8
PostgreSQL and banking API.

### Phase 9
Backup, restore, evidence collection, and final polishing.

## Trade-Offs and Limitations

This project intentionally does not implement the following in the initial version:

- control plane HA
- service mesh
- multi-cluster topology
- enterprise IAM
- point-in-time database recovery

These omissions are deliberate and aligned with the hardware budget and the homelab objective.

## Expected Evidence

The final version of this document should eventually link to:

- topology screenshots
- validation outputs
- runbooks
- recovery drill notes
- dashboards
- related ADRs
