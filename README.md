# 🏡 Terraform & Ansible Homelab with K3s

Automated homelab setup demonstrating **VM provisioning with Terraform** and **K3s Kubernetes deployment with Ansible**. Ideal for showcasing DevOps skills and infrastructure automation. 
This was mainly created for myself to learn Terraform and Ansible within my homelab but I thought of sharing it as it may be useful for other people too (Although there might be millions of them already).

---

## System Requirements:
- Running proxmox environment with Terraform user created with PAM. Good tutorials here: [Learn Linux TV](https://www.youtube.com/watch?v=1kFBk0ePtxo)
- Cloud init image template with qemu agent script - Good tutorials here: [Techno Tim](https://www.youtube.com/watch?v=shiIi38cJe4) or [UntouchedWagons/Ubuntu-CloudInit-Docs](https://github.com/UntouchedWagons/Ubuntu-CloudInit-Docs)
- Terraform installed on remote host or local host
- Ansible installed on remote host or local host

---

## 🌟 Features

- **Provision VMs with Terraform**  
- **Install K3s cluster with Ansible** (1 master + single/multiple workers)  
- **Idempotent and reusable roles**  
- Dynamic cluster discovery: workers automatically join master  
- Full **uninstall playbooks** to clean up cluster  

---

## 📂 Repository Structure

```
.
├── ansible/
│   ├── ansible.cfg
│   ├── inventory/
│   ├── playbooks/
│   └── roles/
├── terraform/
│   └── base-vm-deploy-k3s/
|       ├── main.tf
|       ├── provider.tf
|       ├── variables.auto.tfvars
|       └── variables.tf
└── README.md
```

> [!IMPORTANT]
> It is recommended to go through the code/files and understand what variables need to be changed for your environemnt.

---

## 🚀 Usage

## 1️⃣ Provision VMs

```
cd terraform/base-vm-deploy-k3s
terraform init
terraform apply
```

## 2️⃣ Install K3s Cluster
```
cd ../../ansible

Add ansible.cfg file to ansible directory
```
Example:
```
[defaults]
inventory = inventory/hosts
remote_user = serveradmin
roles_path = ./roles
log_path = ./ansible.log
scp_if_ssh = True
host_key_checking = False
```
```
ansible-playbook playbooks/k3s-install.yml
```

## 3️⃣ Validate Cluster

```
ssh serveradmin@<master_ip>
sudo kubectl get nodes
```
✅ All worker nodes should be joined and Ready.


## 4️⃣ Uninstall K3s if you want a fresh start of VM's (Optional)

```
ansible-playbook playbooks/k3s-uninstall.yml
```
---
## ⚙️ Roles
Roles / Description

 - k3s_master - Installs and configures K3s master node
 - k3s_worker - Installs and joins K3s worker nodes
 - k3s_master_uninstall - Uninstalls K3s master node 
 - k3s_worker_uninstall - Uninstalls K3s worker nodes

