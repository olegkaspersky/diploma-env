resource "google_app_engine_application" "firestore-database" {
  project       = var.gcp_project
  location_id   = var.database_location
  database_type = "CLOUD_FIRESTORE"
}
