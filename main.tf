provider "google" {
  project = var.project_id
  region  = "us-west1"
  zone    = "us-west1-a"
}

data "google_service_account" "myaccount" {
  account_id = var.account_id
  project    = var.project_id
}
