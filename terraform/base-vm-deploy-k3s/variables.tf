variable "vm_count" {
  type    = number
}

variable "base_name" {
  type    = string
  default = "vm"
}

variable "name_start_offset" {
  type    = number
  default = 0
}

variable "vmid_start" {
  type    = number
}

variable "network_cidr" {
  type    = string
  default = "192.168.0.0/24"
}

variable "network_prefix" {
  type    = number
  default = 24
}

variable "ip_start" {
  type    = number
  default = 11
}

variable "gateway" {
  type    = string
  default = "192.168.0.1"
}

variable "dns_primary" {
  type    = string
  default = "192.168.0.1"
}

variable "dns_secondary" {
  type    = string
  default = "8.8.8.8"
}

variable "target_node" {
  type    = string
  default = "pve"
}

variable "ssh_public_key" {
  type    = string
  sensitive = true
  default = "~/.ssh/id_ed25519.pub" # supply via variables.auto.tfvars or env/secret
}

variable "vm_names" {
  type    = list(string)
  default = []
}

variable "vm_defaults" {
  type = map(any)
  default = {
    cores     = 2
    sockets   = 1
    memory    = 4096     # MB
    disk_size = "20G"    # string acceptable by provider
  }
}

variable "vm_specs" {
  type    = list(map(any))
  default = []
}

variable "clone_template" {
  type    = string
  default = "ubuntu-cloud"
}