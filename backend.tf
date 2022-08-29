resource "google_compute_instance_group" "webservers" {
  description = "Personal wesbite instance group"
  name        = "saurabh-cc-webservers"
  network     = "default"
  zone        = "us-west1-a"

  instances = [
    google_compute_instance.website_server.id,
  ]

  named_port {
    name = "http"
    port = "8080"
  }

  named_port {
    name = "https"
    port = "8443"
  }

}
