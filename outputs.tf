output "webapp_ip_address" {
  description = "The static external IP address of the web application."
  value       = google_compute_address.webapp_static_ip.address
}