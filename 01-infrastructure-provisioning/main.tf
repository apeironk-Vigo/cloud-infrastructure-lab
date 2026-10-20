terraform {
  required_version = ">= 1.5.0"
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.4.0"
    }
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.2"
    }
  }
}

provider "local" {}

provider "docker" {}

# Variable defining our environment name
variable "environment" {
  type        = string
  default     = "vigo-lab"
  description = "Target environment tag for our lab resources"
}

# Resource 1: A local configuration file generated via Terraform state
resource "local_file" "lab_inventory" {
  filename = "${path.module}/inventory.ini"
  content  = <<-EOT
    [vigo_servers]
    vigo-caribou-01 ansible_host=127.0.0.1 env=${var.environment}
  EOT
}

# Resource 2: A Docker network for our upcoming reverse proxy & containers
resource "docker_network" "lab_bridge" {
  name   = "vigo-lab-net-${var.environment}"
  driver = "bridge"
}

# Output the generated file path and Docker network name
output "inventory_file_path" {
  value       = local_file.lab_inventory.filename
  description = "Path to the generated Ansible inventory file"
}

output "docker_network_id" {
  value       = docker_network.lab_bridge.id
  description = "ID of the created Docker bridge network"
}