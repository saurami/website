output "public_key_openssh" {
  value       = tls_private_key.webserver_access.public_key_openssh
  description = "Open SSH public key data in 'Authorized Keys' format. \nThis is associated with instance metadata"
  sensitive   = false
}

output "instance_ip" {
  value     = "External (public) IP address of instance is ${google_compute_instance.website_server.network_interface.0.access_config.0.nat_ip}"
  sensitive = false
}

output "instance_connection_string" {
  description = "Command to connect to the compute instance"
  value       = "ssh -i ${local_sensitive_file.private_key.filename} ${var.ssh_user}@${google_compute_instance.website_server.network_interface.0.access_config.0.nat_ip} ${var.host_check} ${var.ignore_known_hosts}"
  sensitive   = false
}

output "instance_url" {
  description = "URL of instance with default webpage (of Apache web server)"
  value       = "http://${google_compute_instance.website_server.network_interface.0.access_config.0.nat_ip}"
  sensitive   = false
}
