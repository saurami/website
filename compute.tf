provider "google" {
  project = var.project_id
  region  = "us-west1"
  zone    = "us-west1-a"
}

data "google_service_account" "myaccount" {
  account_id = var.account_id
  project    = var.project_id
}

resource "google_compute_instance" "webserver-instance" {
  name                      = "webserver"
  description               = "Web Server for Personal Website"
  machine_type              = "f1-micro"
  allow_stopping_for_update = true
  deletion_protection       = false

  tags = ["webserver-instance"]

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
    initialize_params {
      image = "ubuntu-minimal-2204-jammy-v20220816"
    }
  }

  metadata_startup_script = file("./startup.sh")

  network_interface {
    network = "default"

    access_config {}
  }

  metadata = {
    ssh-keys               = "${var.ssh_user}:${local_file.public_key.content}"
    block-project-ssh-keys = true
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
