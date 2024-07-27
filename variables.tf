variable "pm_api_token_id" {
  description = "Proxmox API token ID"
  type        = string
  sensitive   = true
}

variable "pm_api_token_secret" {
  description = "Proxmox API token secret"
  type        = string
  sensitive   = true
}

variable "ssh_key" {
  description = "SSH key to copy to the VMs"
  type        = string
  sensitive   = true
}

variable "nodes_names" {
  description = "List of VM names"
  type        = list(string)
  default     = ["master-01", "worker-01", "worker-02"]
}

variable "nodes_base_name" {
  description = "Base name for VMs"
  type        = string
  default     = "k8s"
}

variable "nodes_ips" {
  description = "Map of VM names to their static IP addresses"
  type        = map(string)
  default     = {
    master-01  = "192.168.100.151"
    worker-01  = "192.168.100.152"
    worker-02  = "192.168.100.153"
  }
}

variable "nodes_gw" {
  description = "Gateway IP for the network"
  type        = string
  default     = "192.168.100.1"
}
