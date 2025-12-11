terraform {
  backend "gcs" {
    bucket = "tfstate-13788"
    prefix = "production/gke"
  }
}
