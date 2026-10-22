# 🚀 Hybrid Cloud & GitOps Infrastructure Lab (`cloud-infrastructure-lab`)

An enterprise-grade, 6-pillar Kubernetes infrastructure lab running on a bare-metal homelab node (`vigo-caribou-01`), demonstrating production-ready DevOps practices: IaC, GitOps CI/CD, Observability, Ingress, and Security.

---

## 🏗️ Architecture Overview

* **Hardware Node:** Lenovo ThinkPad (`vigo-caribou-01`) running Ubuntu 24.04 LTS Server
* **Container Orchestration:** K3s Lightweight Kubernetes
* **GitOps Engine:** ArgoCD & GitHub Actions
* **Ingress Controller:** Traefik Ingress Controller

---

## 🗺️ The 6 Infrastructure Pillars

| Pillar | Focus | Tech Stack | Status |
| :--- | :--- | :--- | :--- |
| **01. Infrastructure Provisioning** | IaC, Docker, Edge Proxy | Terraform, Nginx, Docker | ✅ Complete |
| **02. GitOps & Continuous Delivery** | Automated Build & Sync | GitHub Actions, ArgoCD | ✅ Complete |
| **03. Observability & Monitoring** | Metrics & Telemetry | kube-prometheus-stack, Grafana | ✅ Complete |
| **04. Security, Ingress & Secrets** | Ingress, Sealed Secrets, Isolation | Traefik, Bitnami Sealed Secrets, NetworkPolicies | ✅ Complete |
| **05. Automation & Scripting** | Cluster Management & Health Checks | Bash, Python, Ansible | 🛠️ In Progress |
| **06. Orchestration & High Availability** | Runtime & Workload Scaling | K3s Core, Storage & Backup Policies | 📅 Planned |

---

## 🔒 Security & GitOps Practices

* **Asymmetric Secret Encryption:** Sensitive credentials are encrypted via Bitnami `kubeseal` (`SealedSecret` CRD), allowing safe public Git tracking without exposing secrets.
* **Network Isolation:** Microservices and telemetry namespaces are isolated using K8s `NetworkPolicies`.
* **Declarative CI/CD:** Infrastructure and workloads sync automatically via GitOps workflows.

---

## 👤 Author
**Kambis** — Cloud & Infrastructure Engineer  
*Targeting 100% Remote EU / Spanish Digital Nomad Visa Alignment*