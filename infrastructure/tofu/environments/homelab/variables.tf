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

variable "storage_pool_name" {
  description = "Name of the libvirt storage pool for this lab."
  type        = string
  default     = "bank-platform-lab"
}

variable "storage_pool_path" {
  description = "Directory-backed libvirt storage pool path."
  type        = string
  default     = "/var/lib/libvirt/images/bank-platform-lab"
}

variable "ubuntu_cloud_image_name" {
  description = "Filename to use for the cached Ubuntu cloud image volume."
  type        = string
  default     = "ubuntu-24.04-server-cloudimg-amd64.img"
}

variable "ubuntu_cloud_image_url" {
  description = "Source URL for the Ubuntu 24.04 cloud image."
  type        = string
  default     = "https://cloud-images.ubuntu.com/releases/noble/release/ubuntu-24.04-server-cloudimg-amd64.img"
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
