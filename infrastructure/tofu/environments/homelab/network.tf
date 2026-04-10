resource "libvirt_network" "homelab" {
  name      = local.network_plan.name
  domain    = local.network_plan.domain
  autostart = true

  forward = {
    mode = local.network_plan.mode
  }

  ips = [
    {
      address = local.network_plan.gateway_ip
      prefix  = local.network_plan.prefix

      dhcp = {
        enabled = true

        ranges = [
          {
            start = local.network_plan.dhcp_range.start
            end   = local.network_plan.dhcp_range.end
          }
        ]

        hosts = [
          for _, vm in local.vm_plan : {
            mac  = vm.mac_address
            ip   = vm.ip_address
            name = vm.hostname
          }
        ]
      }
    }
  ]
}
