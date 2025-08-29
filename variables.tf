variable "gcp_project_id" {
  description = "The GCP project ID to deploy resources into."
  type        = string
  sensitive = true
}

variable "gcp_region" {
  description = "The GCP region to deploy resources into."
  type        = string
  default     = "us-central1"
}

variable "cluster_name" {
  description = "The name for the GKE cluster."
  type        = string
  default     = "hit-counter-cluster"
}