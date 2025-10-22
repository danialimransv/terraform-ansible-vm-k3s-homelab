proxmox_api_url = "https://<PROXMOXURL>/api2/json" # Proxmox API URL
proxmox_api_token_id = "terraform@pam!terraform" # Proxmox API token ID
proxmox_api_token_secret = "<token>" # Proxmox API token secret

vm_count = 4 # Number of VMs to create
base_name = "vm" # Base name for VMs
name_start_offset = 0
vmid_start = 150 # Starting VMID for VMs
network_cidr = "192.168.0.0" # Network CIDR
network_prefix = 24 # Network prefix
ip_start = 50 # Starting IP address last octet
gateway = "192.168.0.1" # Gateway IP address
dns_primary = "192.168.0.1" # Primary DNS server
dns_secondary = "8.8.8.8" # Secondary DNS server
target_node = "pve" # Proxmox target node
ssh_public_key = "~/.ssh/id_ed25519.pub" # Path to SSH public key
vm_names = ["masternode", "workernode1", "workernode2", "workernode3" ] # List of VM names

vm_specs = [
  { cores = 3, memory = 3072, disk_size = "40G" },    # vm index 0
  { cores = 2, memory = 4096, disk_size = "50G" },    # vm index 1
  { cores = 2, memory = 4096, disk_size = "50G" },     # vm index 2
  { cores = 2, memory = 2048, disk_size = "40G" }     # vm index 3
]   