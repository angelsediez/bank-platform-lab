# cloud-init

This directory is reserved for cloud-init data used during guest bootstrap.

The goal is to keep guest initialization predictable and versioned without turning early VM setup into an undocumented manual process.

## Expected use

- base package installation
- user setup
- SSH access preparation
- baseline guest configuration
