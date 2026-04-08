# GitOps

This directory contains the GitOps delivery topology for the lab.

Its responsibility is to define how Argo CD will reconcile platform and workload resources once the cluster bootstrap is in place.

## Scope

- root application structure
- bootstrap layer
- project separation
- application grouping for platform and workloads

## Boundary

This directory defines delivery structure and reconciliation intent.

Detailed platform configuration should live outside this directory in the corresponding platform or workload paths.
