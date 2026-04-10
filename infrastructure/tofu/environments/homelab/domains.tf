resource "libvirt_domain" "vm" {
  for_each = local.vm_plan

  depends_on = [
    libvirt_network.homelab,
    libvirt_volume.vm_root_disk,
    libvirt_volume.vm_seed_iso,
  ]

  name        = each.value.hostname
  type        = "kvm"
  memory      = each.value.memory_mb
  memory_unit = "MiB"
  vcpu        = each.value.vcpu
  running     = false
  autostart   = false

  os = {
    type         = "hvm"
    type_arch    = "x86_64"
    type_machine = "q35"
  }

  devices = {
    disks = [
      {
        device = "disk"

        driver = {
          type = "qcow2"
        }

        source = {
          volume = {
            pool   = libvirt_volume.vm_root_disk[each.key].pool
            volume = libvirt_volume.vm_root_disk[each.key].name
          }
        }

        target = {
          dev = "vda"
          bus = "virtio"
        }
      },
      {
        device    = "cdrom"
        read_only = true

        source = {
          volume = {
            pool   = libvirt_volume.vm_seed_iso[each.key].pool
            volume = libvirt_volume.vm_seed_iso[each.key].name
          }
        }

        target = {
          dev = "sda"
          bus = "sata"
        }
      }
    ]

    channels = [
      {
        source = {
          unix = {}
        }

        target = {
          virt_io = {
            name = "org.qemu.guest_agent.0"
          }
        }
      }
    ]

    interfaces = [
      {
        type = "network"
        mac  = each.value.mac_address

        model = {
          type = "virtio"
        }

        source = {
          network = {
            network = libvirt_network.homelab.name
          }
        }
      }
    ]
  }
}
