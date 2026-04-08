# GitOps Bootstrap

This directory is reserved for the minimal GitOps bootstrap layer.

Its role is to hold the first declarative objects needed after Argo CD is available, without trying to represent the full platform configuration here.

## Purpose

- establish the first GitOps entry point
- keep bootstrap responsibilities small
- avoid mixing bootstrap concerns with the full platform structure
