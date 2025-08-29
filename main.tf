terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.50"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.11"
    }
  }
}

provider "google" {
  project = var.gcp_project_id
  region  = var.gcp_region
}

# Create the GKE cluster
resource "google_container_cluster" "primary" {
  name               = var.cluster_name
  location           = var.gcp_region
  initial_node_count = 2 # Reduced for cost-effectiveness, you can keep it at 3 if needed

  node_config {
    machine_type = "e2-medium"
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }
}

# Reserve a static external IP address for the web application
resource "google_compute_address" "webapp_static_ip" {
  name   = "webapp-loadbalancer-ip"
  region = var.gcp_region
}

# Configure the Kubernetes provider to connect to the created cluster
data "google_client_config" "default" {}

provider "kubernetes" {
  host = "https://${google_container_cluster.primary.endpoint}"
  token = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(
    google_container_cluster.primary.master_auth[0].cluster_ca_certificate
  )
}