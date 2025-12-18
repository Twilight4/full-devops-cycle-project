resource "google_project_service" "firestore_api" {
  service = "firestore.googleapis.com"
}

resource "google_firestore_database" "database" {
  project                 = var.project_id
  name                    = var.database_name
  location_id             = var.region
  type                    = var.type
  deletion_policy         = var.deletion_policy
  delete_protection_state = var.delete_protection_state

  depends_on = [
    google_project_service.firestore_api
  ]
}
