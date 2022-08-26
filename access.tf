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
  algorithm = "RSA"
  rsa_bits  = 4096

  provisioner "local-exec" { # Generate "terraform-key-pair.pem" in current directory
    command = <<-EOT
      echo "${tls_private_key.webserver_access.private_key_openssh}" > "${var.webserver_private_key}"
      chmod 400 ./"${var.webserver_private_key}"
    EOT
  }
}


output "public_key" {
  value       = tls_private_key.webserver_access.public_key_openssh
  description = "Public key added to instance metadata for SSH access"
  sensitive   = false
}

output "instance_ip" {
  value     = "External (public) IP address of instance is ${google_compute_instance.webserver-instance.network_interface.0.access_config.0.nat_ip}"
  sensitive = false
}

output "instance_connection_string" {
  description = "Command to connect to the compute instance"
  value       = "ssh -i ${var.webserver_private_key} ${var.ssh_user}@${google_compute_instance.webserver-instance.network_interface.0.access_config.0.nat_ip} ${var.host_check}"
  sensitive   = true
}
