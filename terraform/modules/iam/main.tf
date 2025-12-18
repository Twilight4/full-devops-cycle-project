resource "google_service_account" "movie_api" {
  account_id   = "movie-api-gsa"
  display_name = "Movie API Firestore access"
}

resource "google_project_iam_member" "firestore_access" {
  project = var.project_id
  role    = "roles/datastore.user"
  member  = "serviceAccount:${google_service_account.movie_api.email}"
}

