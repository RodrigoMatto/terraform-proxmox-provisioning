resource "proxmox_vm_qemu" "k8s_server" {
    count       = length(var.nodes_names)
    name        = "${var.nodes_base_name}-${var.nodes_names[count.index]}"
    target_node = "proxmox"
    clone       = "ubuntu-2204-ci"
    full_clone  = true
    
    os_type   = "cloud-init"
    cpu       = "host"
    cores     = 2
    sockets   = "1"
    memory    = 2048
    scsihw    = "virtio-scsi-pci"
    bootdisk  = "scsi0"

# Storage
    disks {
      scsi {
        scsi0 {
          disk {
            size     = "32G"
            storage  = "local"
            format   = "qcow2"
          }
        }
      }
      ide {
        ide2 {
          cloudinit {
            storage = "local"
          }
        }
      }
    }

# Networking

  network {
    model  = "virtio"
    bridge = "vmbr0"
  }

  ipconfig0 = "ip=${lookup(var.nodes_ips, var.nodes_names[count.index])}/24,gw=${var.nodes_gw}"

  cicustom  = "vendor=local:snippets/vendor.yaml"

  sshkeys   = <<EOF
  ${var.ssh_key} 
  EOF


}
