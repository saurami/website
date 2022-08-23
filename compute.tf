provider "google" {
  project = var.project_id
  region  = "us-west1"
}

data "google_service_account" "myaccount" {
  account_id = var.account_id
  project    = var.project_id
}

resource "google_compute_instance" "default" {
  name                      = "webserver"
  description               = "Web Server for Personal Website"
  machine_type              = "f1-micro"
  zone                      = "us-west1-b"
  allow_stopping_for_update = true
  deletion_protection       = false

  tags = ["static-files", "webserver"]

  shielded_instance_config {
    enable_secure_boot          = true
    enable_vtpm                 = true
    enable_integrity_monitoring = true
  }

  scheduling {
    provisioning_model  = "standard"
    on_host_maintenance = "TERMINATE"
    automatic_restart   = true
  }

  boot_disk {
    initialize_params {
      image = "ubuntu-minimal-2204-lts-arm64"
      type  = "pd-balanced"
    }
  }

  metadata_startup_script = file("./startup.sh")

  network_interface {
    subnetwork = "default"

    access_config {
      network_tier = "PREMIUM"
    }
  }

  metadata = {
    terraform = "true"
    purpose   = "host static files for website"
  }

  service_account {
    # Custom service account with restricted permissions
    email  = data.google_service_account.myaccount.email
    scopes = ["compute-rw"]
  }
}
