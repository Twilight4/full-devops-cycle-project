terraform {
  backend "gcs" {
    bucket = "tfstate-13788"
    prefix = "staging/gke"
  }
}
