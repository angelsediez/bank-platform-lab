locals {
  naming = {
    lab_name         = var.lab_name
    environment_name = var.environment_name
    resource_prefix  = "${var.lab_name}-${var.environment_name}"
  }

  network_plan = {
    name       = var.libvirt_network_name
    mode       = "nat"
    cidr       = var.libvirt_network_cidr
    domain     = var.libvirt_network_domain
    gateway_ip = cidrhost(var.libvirt_network_cidr, 1)

    management_ip = cidrhost(var.libvirt_network_cidr, 10)
    k3s_server_ip = cidrhost(var.libvirt_network_cidr, 11)
    worker_1_ip   = cidrhost(var.libvirt_network_cidr, 12)
    worker_2_ip   = cidrhost(var.libvirt_network_cidr, 13)

    metallb_pool = {
      start = var.metallb_address_range_start
      end   = var.metallb_address_range_end
    }
  }

  cloud_init_templates = {
    vm_mgmt       = "${path.module}/../../../cloud-init/templates/vm-mgmt.yaml.tftpl"
    vm_k3s_server = "${path.module}/../../../cloud-init/templates/vm-k3s-server.yaml.tftpl"
    vm_k3s_worker = "${path.module}/../../../cloud-init/templates/vm-k3s-worker.yaml.tftpl"
  }

  vm_plan = {
    "vm-mgmt" = {
      role            = "management"
      hostname        = "vm-mgmt"
      ip_address      = local.network_plan.management_ip
      vcpu            = 2
      memory_mb       = 4096
      disk_gb         = 50
      cloud_init_file = local.cloud_init_templates.vm_mgmt
    }

    "vm-k3s-server" = {
      role            = "k3s-server"
      hostname        = "vm-k3s-server"
      ip_address      = local.network_plan.k3s_server_ip
      vcpu            = 4
      memory_mb       = 6144
      disk_gb         = 60
      cloud_init_file = local.cloud_init_templates.vm_k3s_server
    }

    "vm-k3s-worker-1" = {
      role            = "k3s-worker"
      hostname        = "vm-k3s-worker-1"
      ip_address      = local.network_plan.worker_1_ip
      vcpu            = 4
      memory_mb       = 8192
      disk_gb         = 80
      cloud_init_file = local.cloud_init_templates.vm_k3s_worker
    }

    "vm-k3s-worker-2" = {
      role            = "k3s-worker"
      hostname        = "vm-k3s-worker-2"
      ip_address      = local.network_plan.worker_2_ip
      vcpu            = 4
      memory_mb       = 8192
      disk_gb         = 80
      cloud_init_file = local.cloud_init_templates.vm_k3s_worker
    }
  }

  cloud_init_defaults = {
    timezone             = var.default_timezone
    admin_username       = var.admin_username
    admin_ssh_public_key = var.admin_ssh_public_key
    lab_domain           = var.libvirt_network_domain
  }
}
