resource "google_compute_instance" "website_server" {
  name                      = "webserver"
  description               = "Web Server for Personal Website"
  machine_type              = "f1-micro"
  allow_stopping_for_update = true
  deletion_protection       = false

  tags = ["webserver-instance", "http-server"]

  shielded_instance_config {
    enable_secure_boot          = true
    enable_vtpm                 = true
    enable_integrity_monitoring = true
  }

  scheduling {
    provisioning_model  = "STANDARD"
    on_host_maintenance = "TERMINATE"
    automatic_restart   = true
  }

  boot_disk {
    mode        = "READ_WRITE"
    auto_delete = true
    initialize_params {
      image = "ubuntu-minimal-2204-jammy-v20220816"
      type  = "pd-balanced"
    }
  }

  metadata_startup_script = file("./startup.sh")

  network_interface {
    network = "default"

    access_config {
      network_tier = "PREMIUM"
    }
  }

  metadata = {
    ssh-keys               = "${var.ssh_user}:${local_file.public_key.content}"
    block-project-ssh-keys = true
  }

  # Used by file/remote-exec provisioners
  # Timeout should be greater than instance (re-)creation
  connection {
    host        = google_compute_instance.website_server.network_interface.0.access_config.0.nat_ip
    type        = "ssh"
    user        = var.ssh_user
    timeout     = "300s"
    private_key = file(local_sensitive_file.private_key.filename)
  }

  # Copies the file as non-root user using SSH
  provisioner "file" {
    source = local_file.landing_page.filename
    destination = "/home/saurabh/index.html"
  }

  provisioner "file" {
    source = local_file.virtual_host.filename
    destination = "/home/saurabh/saurabh.cc.conf"
  }

  labels = {
    terraform = "true"
    purpose   = "host-static-files"
  }

  service_account {
    # Custom service account with restricted permissions
    email  = data.google_service_account.myaccount.email
    scopes = ["compute-rw"]
  }

}
