resource "google_compute_firewall" "webserver_access" {
  description = "Allow SSH and HTTP access"
  name        = "webserver-firewall"
  network     = "default"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  allow {
    protocol = "tcp"
    ports    = ["80", "8080"]
  }

  target_tags   = ["webserver-instance", "http-server"]
  source_ranges = ["0.0.0.0/0"]
}

resource "tls_private_key" "webserver_access" {
  algorithm = "ED25519"
}

resource "local_file" "public_key" {
  filename        = "server_public_openssh"
  content         = trimspace(tls_private_key.webserver_access.public_key_openssh)
  file_permission = "0400"
}

resource "local_sensitive_file" "private_key" {
  filename = "server_private_openssh"
  # IMPORTANT: Newline is required at end of open SSH private key file
  content         = tls_private_key.webserver_access.private_key_openssh
  file_permission = "0400"
}
