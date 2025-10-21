# 🏡 Terraform & Ansible Homelab with K3s

[![License](https://img.shields.io/badge/license-MIT-green)](LICENSE)
[![Ansible](https://img.shields.io/badge/ansible-2.19-blue)](https://docs.ansible.com/)
[![Terraform](https://img.shields.io/badge/terraform-1.7-blue)](https://www.terraform.io/)

Automated homelab setup demonstrating **VM provisioning with Terraform** and **K3s Kubernetes deployment with Ansible**. Ideal for showcasing DevOps skills and infrastructure automation.

---

## 🌟 Features

- **Provision VMs with Terraform**  
- **Install K3s cluster with Ansible** (1 master + multiple workers)  
- **Idempotent and reusable roles**  
- Dynamic cluster discovery: workers automatically join master  
- Full **uninstall playbooks** to clean up cluster  

---

## 📂 Repository Structure

```text
.
├── ansible/
│   ├── ansible.cfg
│   ├── inventory/
│   ├── playbooks/
│   └── roles/
├── terraform/
│   └── base-vm-deploy-k3s/
└── README.md

🚀 Usage
1️⃣ Provision VMs
cd terraform/base-vm-deploy-k3s
terraform init
terraform apply

2️⃣ Install K3s Cluster
cd ../../ansible
ansible-playbook playbooks/k3s-install.yml

3️⃣ Validate Cluster
ssh serveradmin@<master_ip>
sudo kubectl get nodes


✅ All worker nodes should be joined and Ready.

4️⃣ Uninstall K3s (Optional)
ansible-playbook playbooks/k3s-uninstall.yml

🎨 Demo / Screenshot
<p align="center"> <img src="assets/demo.png" alt="K3s cluster demo" width="600"/> </p>

Replace assets/demo.png with an actual screenshot or GIF of your homelab/K3s cluster.

⚙️ Roles
Role	Description
k3s_master	Installs and configures K3s master node
k3s_worker	Installs and joins K3s worker nodes
k3s_master_uninstall	Uninstalls K3s master node
k3s_worker_uninstall	Uninstalls K3s worker nodes
