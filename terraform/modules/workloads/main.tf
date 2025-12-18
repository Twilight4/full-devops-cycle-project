resource "google_service_account_iam_member" "workload_identity" {
  service_account_id = var.gcp_service_account_name
  role               = "roles/iam.workloadIdentityUser"
  member             = "serviceAccount:${var.project_id}.svc.id.goog[default/movie-api-sa]"
}
