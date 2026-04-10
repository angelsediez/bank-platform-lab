output "naming" {
  description = "Environment naming information."
  value       = local.naming
}

output "network_plan" {
  description = "Planned libvirt network layout for the homelab."
  value       = local.network_plan
}

output "vm_plan" {
  description = "Planned virtual machine topology for the homelab."
  value       = local.vm_plan
}

output "cloud_init_defaults" {
  description = "Common values expected by the cloud-init templates."
  value       = local.cloud_init_defaults
}

output "cloud_init_templates" {
  description = "Cloud-init template paths referenced by this environment."
  value       = local.cloud_init_templates
}
