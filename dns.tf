# This file is optional. It shows how to manage your DNS records with Terraform
# using Google Cloud DNS.

# Creates a Managed DNS Zone in Google Cloud for your domain.
# After this is created, you must update the Name Server (NS) records
# at your domain registrar to point to the servers listed in the 'name_servers' output.
resource "google_dns_managed_zone" "avs_ops_zone" {
  provider    = google
  name        = "avs-ops-online-zone" 
  dns_name    = "avs-ops.online."     
  description = "Managed zone for avs-ops.online"
}

# Creates the 'A' record to point your domain to the static IP.
resource "google_dns_record_set" "webapp_dns" {
  provider     = google
  name         = google_dns_managed_zone.avs_ops_zone.dns_name
  type         = "A"
  ttl          = 300
  managed_zone = google_dns_managed_zone.avs_ops_zone.name
  rrdatas      = [google_compute_address.webapp_static_ip.address]
}

output "name_servers" {
  description = "Name servers for the managed DNS zone. Update these in your domain registrar."
  value       = google_dns_managed_zone.avs_ops_zone.name_servers
}