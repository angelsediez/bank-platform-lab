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
    prefix     = tonumber(split("/", var.libvirt_network_cidr)[1])
    domain     = var.libvirt_network_domain
    gateway_ip = cidrhost(var.libvirt_network_cidr, 1)

    dhcp_range = {
      start = cidrhost(var.libvirt_network_cidr, 100)
      end   = cidrhost(var.libvirt_network_cidr, 199)
    }

    management_ip = cidrhost(var.libvirt_network_cidr, 10)
    k3s_server_ip = cidrhost(var.libvirt_network_cidr, 11)
    worker_1_ip   = cidrhost(var.libvirt_network_cidr, 12)
    worker_2_ip   = cidrhost(var.libvirt_network_cidr, 13)

    metallb_pool = {
      start = var.metallb_address_range_start
      end   = var.metallb_address_range_end
    }
  }

  storage_plan = {
    pool_name       = var.storage_pool_name
    pool_path       = var.storage_pool_path
    base_image_name = var.ubuntu_cloud_image_name
    base_image_url  = var.ubuntu_cloud_image_url
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
      mac_address     = "52:54:00:15:00:10"
      vcpu            = 2
      memory_mb       = 4096
      disk_gb         = 50
      root_disk_name  = "vm-mgmt.qcow2"
      seed_iso_name   = "vm-mgmt-seed.iso"
      cloud_init_file = local.cloud_init_templates.vm_mgmt
    }

    "vm-k3s-server" = {
      role            = "k3s-server"
      hostname        = "vm-k3s-server"
      ip_address      = local.network_plan.k3s_server_ip
      mac_address     = "52:54:00:15:00:11"
      vcpu            = 4
      memory_mb       = 6144
      disk_gb         = 60
      root_disk_name  = "vm-k3s-server.qcow2"
      seed_iso_name   = "vm-k3s-server-seed.iso"
      cloud_init_file = local.cloud_init_templates.vm_k3s_server
    }

    "vm-k3s-worker-1" = {
      role            = "k3s-worker"
      hostname        = "vm-k3s-worker-1"
      ip_address      = local.network_plan.worker_1_ip
      mac_address     = "52:54:00:15:00:12"
      vcpu            = 4
      memory_mb       = 8192
      disk_gb         = 80
      root_disk_name  = "vm-k3s-worker-1.qcow2"
      seed_iso_name   = "vm-k3s-worker-1-seed.iso"
      cloud_init_file = local.cloud_init_templates.vm_k3s_worker
    }

    "vm-k3s-worker-2" = {
      role            = "k3s-worker"
      hostname        = "vm-k3s-worker-2"
      ip_address      = local.network_plan.worker_2_ip
      mac_address     = "52:54:00:15:00:13"
      vcpu            = 4
      memory_mb       = 8192
      disk_gb         = 80
      root_disk_name  = "vm-k3s-worker-2.qcow2"
      seed_iso_name   = "vm-k3s-worker-2-seed.iso"
      cloud_init_file = local.cloud_init_templates.vm_k3s_worker
    }
  }

  cloud_init_defaults = {
    timezone             = var.default_timezone
    admin_username       = var.admin_username
    admin_ssh_public_key = var.admin_ssh_public_key
    lab_domain           = var.libvirt_network_domain
  }

  cloud_init_render_context = {
    for vm_name, vm in local.vm_plan : vm_name => {
      hostname             = vm.hostname
      lab_domain           = local.cloud_init_defaults.lab_domain
      timezone             = local.cloud_init_defaults.timezone
      admin_username       = local.cloud_init_defaults.admin_username
      admin_ssh_public_key = local.cloud_init_defaults.admin_ssh_public_key
    }
  }
}
