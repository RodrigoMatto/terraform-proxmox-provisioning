# Terraform Proxmox Provisioning

The **Terraform Proxmox Provisioning** project is designed to automate the creation and configuration of virtual machines on a Proxmox server using Terraform. This setup allows for the provisioning of VMs with static IP addresses, custom node names, and gateway configurations, making it suitable for deploying Kubernetes clusters or other environments.

## Features

- **Automated VM Provisioning**: Create and configure VMs on Proxmox with Terraform.
- **Static IP Configuration**: Assign static IPs to VMs based on their names.
- **Customizable Nodes**: Easily modify node names, static IPs, and gateways.

## Prerequisites

Before using this project, ensure you have the following prerequisites installed and configured:

- Proxmox server
- Terraform
- Cloud-init template

For detailed steps on generating your own cloud-init template, and more in deep configuration of this project, please refer to the first part of my [blog post]()*.

*The blog will be published tomorrow :D If it's not, please come back and read this part again.

## Configuration

Before provisioning the VMs, you need to configure the environment variables and modify the `variables.tf` and `main.tf` files according to your setup.

### Environment variables

Set the following environment variables:

- `PM_API_URL`: The URL of your Proxmox API.
- `PM_TOKEN_ID`: Your Proxmox token ID.
- `PM_TOKEN_SECRET`: Your Proxmox token secret.
- `SSH_KEY`: The SSH key for accessing the VMs.

Example:
```bash
export TF_VAR_pm_api_url=https://proxmox.example.com:8006/api2/json
export TF_VAR_pm_api_token_id=your_token_id
export TF_VAR_pm_api_token_secret=your_token_secret
export TF_VAR_ssh_key=$(cat ~/.ssh/id_rsa.pub)
```

### Modify variables.tf

Update the variables.tf file to set up your node names, static IPs, and gateway:

```bash
variable "nodes_ips" {
  description = "Map of VM names to their static IP addresses"
  type        = map(string)
  default     = {
    master-01  = "192.168.100.151"  // Change
    worker-01  = "192.168.100.152"  // those
    worker-02  = "192.168.100.153"  // values
  }
}

variable "nodes_gw" {
  description = "Gateway IP for the network"
  type        = string
  default     = "192.168.100.1"     // This one too
}
```
You can add or remove as many nodes as you want here, terraform will handle it.

### Verify and modify main.tf

Ensure that the main.tf file matches your Proxmox server's storage and network configurations. Verify and modify the storage and network sections as needed. For example, if your storage is `local` or `local-lvm` and the network interface is `vmbr0`, ensure these are correctly specified:

```bash
# Storage
    disks {
      scsi {
        scsi0 {
          disk {
            size     = "32G"
            storage  = "local"  // Check this storage 
            format   = "qcow2"
          }
        }
      }
      ide {
        ide2 {
          cloudinit {
            storage = "local"   // this one too
          }
        }
      }
    }

# Networking

  network {
    model  = "virtio"
    bridge = "vmbr0"            // and the bridge you are using
  }
```

## Usage

To provision the VMs, once you have cloned the repository and configured your enviroment variables, follow these steps:


```bash
cd terraform-proxmox-provisioning
```

Initialize Terraform:

```bash
terraform init
```

Apply the Terraform configuration:

```bash
terraform apply
````

Review the plan and confirm to proceed with the provisioning.

## Disclaimer

This project is intended for testing purposes only and should not be used in a production environment as is.

## Additional Resources

For more information on using Proxmox with Terraform, refer to the official documentation:

[Telmante Proxmox Terraform Provider](https://registry.terraform.io/providers/Telmate/proxmox/latest/docs/resources/vm_qemu)