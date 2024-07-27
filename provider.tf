terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "3.0.1-rc3"
    }
  }
}

# Proxmox Configuration
provider "proxmox" {
   pm_api_url           = "https://192.168.100.26:8006/api2/json"
   pm_user              = "terraform"
   pm_api_token_id      = var.pm_api_token_id
   pm_api_token_secret  = var.pm_api_token_secret
   pm_tls_insecure      = true
}

