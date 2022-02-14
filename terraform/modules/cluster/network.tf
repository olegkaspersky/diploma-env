resource "google_compute_network" "cluster_network" {
  name                    = var.network_name
  auto_create_subnetworks = false
  mtu                     = 1460
}


resource "google_compute_subnetwork" "cluster_subnetwork" {
  name                     = var.network_name
  ip_cidr_range            = var.subnet_range
  private_ip_google_access = true
  region                   = var.project_region
  network                  = google_compute_network.cluster_network.id

  log_config {
    aggregation_interval = "INTERVAL_5_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}


resource "google_compute_router" "router" {
  name    = var.network_name
  network = google_compute_network.cluster_network.name
  region  = var.project_region
}


resource "google_compute_router_nat" "nat" {
  name                               = var.network_name
  router                             = google_compute_router.router.name
  region                             = google_compute_router.router.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}
