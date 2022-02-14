module "cluster" {
  source = "../modules/cluster"

  network_name   = "staging"
  subnet_range   = "10.0.0.0/24"
  cluster_name   = "staging-cluster"
  project_region = "europe-north1"
}
