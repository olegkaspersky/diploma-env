module "cluster" {
  source = "../modules/cluster"

  gcp_project    = "staging-338816"
  project_region = "europe-north1"
  network_name   = "staging"
  subnet_range   = "10.0.0.0/24"

  cluster_name = "staging-cluster"
  cluster_resource_labels = {
    "environment" = "staging"
  }
  cluster_nodes_labels = {
    "service"     = "kubernetes",
    "environment" = "staging"
  }
}
