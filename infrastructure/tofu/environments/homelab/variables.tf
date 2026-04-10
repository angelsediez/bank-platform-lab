variable "lab_name" {
  description = "Logical name of the lab."
  type        = string
  default     = "bank-platform-lab"
}

variable "environment_name" {
  description = "Environment name for this OpenTofu stack."
  type        = string
  default     = "homelab"
}

variable "libvirt_uri" {
  description = "Libvirt connection URI."
  type        = string
  default     = "qemu:///system"
}

variable "libvirt_network_name" {
  description = "Name of the libvirt network that will back the lab."
  type        = string
  default     = "bank-platform-lab-net"
}

variable "libvirt_network_cidr" {
  description = "CIDR block reserved for the libvirt NAT network."
  type        = string
  default     = "192.168.150.0/24"
}

variable "libvirt_network_domain" {
  description = "DNS domain for the libvirt network."
  type        = string
  default     = "lab.internal"
}

variable "metallb_address_range_start" {
  description = "First IP in the MetalLB address pool."
  type        = string
  default     = "192.168.150.240"
}

variable "metallb_address_range_end" {
  description = "Last IP in the MetalLB address pool."
  type        = string
  default     = "192.168.150.250"
}

variable "default_timezone" {
  description = "Timezone applied by cloud-init templates."
  type        = string
  default     = "UTC"
}

variable "admin_username" {
  description = "Primary administrative user that will be created by cloud-init."
  type        = string
  default     = "labadmin"
}

variable "admin_ssh_public_key" {
  description = "SSH public key for the administrative user."
  type        = string
  default     = "ssh-ed25519 CHANGE_ME"
}
