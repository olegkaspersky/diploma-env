resource "google_compute_firewall" "nginx-ingress-controller" {
  name        = "nginx-ingress-controller"
  network     = google_compute_network.cluster_network.id
  description = "For the ingress controller to work, the control panel needs access to port 8443 of the nodes"

  allow {
    protocol = "tcp"
    ports    = ["8443"]
  }

  target_tags   = var.cluster_nodes_tags
  source_ranges = ["0.0.0.0/0"]
}
