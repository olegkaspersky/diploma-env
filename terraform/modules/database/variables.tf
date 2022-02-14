variable "gcp_project" {
  description = "GCP project"
  type        = string
  sensitive   = true
}


variable "database_location" {
  description = "Firestore database location"
  type        = string
  sensitive   = true
}
