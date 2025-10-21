locals {
  generated_names = [for i in range(var.vm_count) : format("%s%02d", var.base_name, i + var.name_start_offset)]

  names = length(var.vm_names) >= var.vm_count ? slice(var.vm_names, 0, var.vm_count) : concat(var.vm_names, slice(local.generated_names, length(var.vm_names), var.vm_count))

  vms = [
    for i in range(var.vm_count) : {
      index = i
      name  = local.names[i]
      ip    = cidrhost(var.network_cidr, var.ip_start + i)
      vmid  = var.vmid_start + i
    }
  ]
}

resource "proxmox_vm_qemu" "ubuntu-cloud" {
  for_each = { for i in range(var.vm_count) : tostring(i) => i }

  vmid = var.vmid_start + each.value
  name = length(var.vm_names) > each.value ? var.vm_names[each.value] : local.names[each.value]

  target_node      = var.target_node
  agent            = 1
  scsihw           = "virtio-scsi-pci"
  boot             = "order=scsi0"
  ciuser           = "serveradmin"
  cicustom         = "vendor=local:snippets/qemu-guest-agent.yml"
  ciupgrade        = true
  vm_state         = "running"
  automatic_reboot = true
  skip_ipv6        = true
  sshkeys          = file(var.ssh_public_key)
  clone            = var.clone_template

  # cpu & memory use per-vm spec if present, else vm_defaults
  cpu {
    cores   = lookup(length(var.vm_specs) > each.value ? var.vm_specs[each.value] : {}, "cores", var.vm_defaults["cores"])
    sockets = lookup(length(var.vm_specs) > each.value ? var.vm_specs[each.value] : {}, "sockets", var.vm_defaults["sockets"])
  }

  memory = lookup(length(var.vm_specs) > each.value ? var.vm_specs[each.value] : {}, "memory", var.vm_defaults["memory"])

  # compute IP inline
  ipconfig0 = "ip=${cidrhost(var.network_cidr, var.ip_start + each.value)}/${var.network_prefix},gw=${var.gateway},ip6=dhcp"

  serial {
    id = 0
  }

  disks {
    scsi {
      scsi0 {
        disk {
          storage = "local-lvm"
          size    = lookup(length(var.vm_specs) > each.value ? var.vm_specs[each.value] : {}, "disk_size", var.vm_defaults["disk_size"])
        }
      }
    }

    ide {
      ide2 {
        cloudinit {
          storage = "local-lvm"
        }
      }
    }
  }

  network {
    id     = 0
    bridge = "vmbr0"
    model  = "virtio"
  }
}
