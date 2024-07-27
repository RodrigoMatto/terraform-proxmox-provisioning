resource "proxmox_vm_qemu" "k8s_server" {
    count = 1 
    name  = "k8s-master01"
    target_node = "proxmox"
    clone = "ubuntu-2204-ci"
    full_clone = true
    
    os_type  = "cloud-init"
    cpu      = "host"
    cores      = 2
    sockets  = "1"
    memory     = 2048
    scsihw   = "virtio-scsi-pci"
    bootdisk = "scsi0"

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

  ipconfig0 = "ip=192.168.100.154/24,gw=192.168.100.1"

  sshkeys = <<EOF
  ${var.ssh_key} 
  EOF


}
