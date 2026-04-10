resource "libvirt_pool" "homelab" {
  name = local.storage_plan.pool_name
  type = "dir"

  target = {
    path = local.storage_plan.pool_path
  }

  create = {
    build     = true
    start     = true
    autostart = true
  }

  destroy = {
    delete = false
  }
}

resource "libvirt_volume" "ubuntu_cloud_image" {
  name = local.storage_plan.base_image_name
  pool = libvirt_pool.homelab.name

  target = {
    format = {
      type = "qcow2"
    }
  }

  create = {
    content = {
      url = local.storage_plan.base_image_url
    }
  }
}

resource "libvirt_volume" "vm_root_disk" {
  for_each = local.vm_plan

  name          = each.value.root_disk_name
  pool          = libvirt_pool.homelab.name
  capacity      = each.value.disk_gb
  capacity_unit = "GiB"

  target = {
    format = {
      type = "qcow2"
    }
  }

  backing_store = {
    path = libvirt_volume.ubuntu_cloud_image.path
    format = {
      type = "qcow2"
    }
  }

  depends_on = [libvirt_volume.ubuntu_cloud_image]
}

resource "libvirt_cloudinit_disk" "vm_seed_source" {
  for_each = local.vm_plan

  name = each.value.seed_iso_name

  user_data = templatefile(
    each.value.cloud_init_file,
    local.cloud_init_render_context[each.key]
  )

  meta_data = yamlencode({
    "instance-id"    = each.value.hostname
    "local-hostname" = each.value.hostname
  })
}

resource "libvirt_volume" "vm_seed_iso" {
  for_each = local.vm_plan

  name = each.value.seed_iso_name
  pool = libvirt_pool.homelab.name

  target = {
    format = {
      type = "iso"
    }
  }

  create = {
    content = {
      url = libvirt_cloudinit_disk.vm_seed_source[each.key].path
    }
  }

  depends_on = [libvirt_cloudinit_disk.vm_seed_source]
}
