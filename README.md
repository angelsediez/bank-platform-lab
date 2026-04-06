# Bank Platform Lab

[![](https://img.shields.io/badge/Status-Active_Practice-success?style=flat-square&color=2d3436)](#)
[![](https://img.shields.io/badge/Environment-KVM/libvirt-blue?style=flat-square&logo=linux&logoColor=white&color=2d3436)](#)
[![](https://img.shields.io/badge/Workflow-GitOps-orange?style=flat-square&logo=argocd&logoColor=white&color=2d3436)](#)
[![](https://img.shields.io/badge/Telemetry-LGTM_Stack-green?style=flat-square&logo=grafana&logoColor=white&color=2d3436)](#)

**A personal homelab for exploring platform engineering patterns, infrastructure automation, and the challenges of running stateful systems with discipline.**

---

## Laboratory Overview

The **bank-platform-lab** is a persistent environment dedicated to iterative learning and technical experimentation. Rather than a static demo, this project serves as a testing ground for bridging the gap between theoretical cloud-native architecture and the practicalities of managing a local, resource-constrained cluster.

The focus here is on **operational discipline**: moving beyond the initial deployment to understand how systems behave over time, how they fail, and how they are recovered through automated reconciliation.

---

## Engineering Focus

This lab provides a sandbox to explore platform patterns under realistic operational constraints:

* **Infrastructure Provenance:** Using OpenTofu and libvirt to treat bare-metal virtualization as a deterministic, code-defined resource.
* **Stateful Resilience:** Managing PostgreSQL persistence through Longhorn to practice volume lifecycle management and backup/restore workflows.
* **Deep Observability:** Implementing the LGTM stack (Loki, Grafana, Tempo, Prometheus) not just for dashboards, but for debugging complex interactions via distributed tracing.
* **Network Sovereignty:** Leveraging Cilium and Hubble to move toward identity-based security and fine-grained traffic visibility at the kernel level.
* **Declarative Delivery:** Enforcement of cluster state through Argo CD, treating the Git repository as the single source of truth for all configurations.

---

## Technical Stack

### Infrastructure & Orchestration
![](https://img.shields.io/badge/Fedora-51A2DA?style=for-the-badge&logo=fedora&logoColor=white)
![](https://img.shields.io/badge/Ubuntu-E95420?style=for-the-badge&logo=ubuntu&logoColor=white)
![](https://img.shields.io/badge/K3s-FFC61C?style=for-the-badge&logo=kubernetes&logoColor=black)
![](https://img.shields.io/badge/OpenTofu-FF4400?style=for-the-badge&logo=opentofu&logoColor=white)
![](https://img.shields.io/badge/Libvirt-005BA9?style=for-the-badge&logo=linux&logoColor=white)

### Platform & Workload Components
![](https://img.shields.io/badge/Argo_CD-EF7B4D?style=for-the-badge&logo=argo-cd&logoColor=white)
![](https://img.shields.io/badge/Cilium-0073E1?style=for-the-badge&logo=cilium&logoColor=white)
![](https://img.shields.io/badge/PostgreSQL-4169E1?style=for-the-badge&logo=postgresql&logoColor=white)
![](https://img.shields.io/badge/Go-00ADD8?style=for-the-badge&logo=go&logoColor=white)

### Observability & Telemetry
![](https://img.shields.io/badge/Prometheus-E6522C?style=for-the-badge&logo=prometheus&logoColor=white)
![](https://img.shields.io/badge/Grafana-F46800?style=for-the-badge&logo=grafana&logoColor=white)
![](https://img.shields.io/badge/OpenTelemetry-000000?style=for-the-badge&logo=opentelemetry&logoColor=white)

---

## Architecture Summary

This setup models a small multi-node platform environment on a single physical workstation, leveraging KVM/QEMU for local virtualization.

### Topology
* **Host:** Fedora 43
* **Nodes:** 4x Ubuntu Server 24.04 VMs
    * `1x Control Plane` (K3s Server)
    * `2x Workers` (K3s Agents)
    * `1x Admin/Management VM` (Bastion & Tooling)

### Integrated Services
* **Connectivity:** MetalLB and Traefik handle service exposure and ingress.
* **Encryption:** Automated TLS management via `cert-manager`.
* **Workload:** A minimalist Go REST API simulating a banking backend to generate stateful traffic and telemetry.

---

## Homelab Constraints

Building in a limited environment necessitates a disciplined design approach. These constraints are treated as fixed engineering inputs rather than limitations:

> **Hardware Context**
> * **Compute:** AMD Ryzen Threadripper 1950X (16C/32T)
> * **Memory:** 32 GB DDR4
> * **Fast Storage:** 1 TB NVMe (Active VM disks)
> * **Mass Storage:** 6 TB HDD (Persistence, backups, and historical logs)

---

## Repository Map

```text
.
├── infrastructure/    # OpenTofu manifests for libvirt and cloud-init
├── gitops/            # Argo CD applications, projects, and sync topology
├── platform/          # Helm values and custom resource definitions
├── app/               # Banking API source (Go) and local manifests
├── scripts/           # Automation for bootstrap and validation
├── docs/              # Architecture docs, ADRs, runbooks, and troubleshooting guides
└── evidence/          # Artifacts from testing and recovery experiments
```

---

## Why this Laboratory Exists

The primary driver for this project is **technical curiosity and long-term growth**. It serves as a personal laboratory to:

1.  **Bridge the Abstraction Gap:** Understanding how Kubernetes actually interacts with underlying Linux primitives like KVM and eBPF.
2.  **Practice Resilience:** Creating a space where it is safe to break storage volumes or network policies to observe failure modes and refine recovery scripts.
3.  **Refine Implementation Patterns:** Testing different approaches to secrets management, ingress routing, and observability schemas before documenting them as personal best practices.
4.  **Continuous Improvement:** The lab is never "finished"; it is an ongoing project where components are swapped and upgraded as new patterns emerge in the ecosystem.

---

## Disclaimer
*This repository is a personal homelab environment. While it follows professional engineering practices, it is built for learning, experimentation, and architectural exploration under real hardware constraints.*

---
**Persistent Infrastructure** | **Iterative Design** | **Managed with Discipline**
