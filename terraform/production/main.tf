module "cluster" {
  source = "../modules/cluster"

  gcp_project    = "production-339118"
  project_region = "europe-north1"
  network_name   = "production"
  subnet_range   = "10.0.0.0/24"

  cluster_name = "production-cluster"
  cluster_resource_labels = {
    "environment" = "production"
  }
  cluster_nodes_labels = {
    "service"     = "kubernetes",
    "environment" = "production"
  }
}
