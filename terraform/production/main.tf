module "cluster" {
  source = "../modules/cluster"

  gcp_project    = "production-339118"
  network_name   = "production"
  subnet_range   = "10.0.0.0/24"
  cluster_name   = "production-cluster"
  project_region = "europe-north1"
}


module "database" {
  source = "../modules/database"

  database_location = "europe-west"
}
