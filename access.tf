resource "google_compute_firewall" "webserver_ssh" {
  name    = "webserver-firewall"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  target_tags   = ["webserver-instance"]
  source_ranges = ["0.0.0.0/0"]
}


resource "tls_private_key" "webserver_access" {
  algorithm = "ED25519"
}


resource "local_file" "private_key" {
  # IMPORTANT: Newline is required at end of open ssh privsate key file
  content         = tls_private_key.webserver_access.private_key_openssh
  filename        = "server_private_openssh"
  file_permission = "0400"
}

resource "local_file" "public_key" {
  content         = trimspace(tls_private_key.webserver_access.public_key_openssh)
  filename        = "server_public_openssh"
  file_permission = "0400"
}


output "public_key_openssh" {
  value       = tls_private_key.webserver_access.public_key_openssh
  description = "The public key data in 'Authorized Keys' format."
  sensitive   = false
}


output "public_key_pem" {
  value       = tls_private_key.webserver_access.public_key_pem
  description = "Public key data in PEM (RFC 1421) format."
  sensitive   = false
}

output "instance_ip" {
  value     = "External (public) IP address of instance is ${google_compute_instance.webserver-instance.network_interface.0.access_config.0.nat_ip}"
  sensitive = false
}

output "instance_connection_string" {
  description = "Command to connect to the compute instance"
  value       = "ssh -i ${local_file.private_key.filename} ${var.ssh_user}@${google_compute_instance.webserver-instance.network_interface.0.access_config.0.nat_ip} ${var.host_check}"
  sensitive   = false
}
