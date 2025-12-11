#!/bin/bash
set -euo pipefail

PROJECT_ID="movie-review-platform8451"     # Project ID
BUCKET_NAME="tfstate-$RANDOM"              # Bucket name
LOCATION="europe-central2"                 # Region
SA_NAME="terraform"                        # Service account name

# The iam.gserviceaccount.com is the domain suffix for all GCP service accounts
SA_EMAIL="$SA_NAME@$PROJECT_ID.iam.gserviceaccount.com"

# Key file for terraform usage
KEY_FILE="terraform-sa-key.json"

log() {
  echo "[INFO] $1"
}

error() {
  echo "[ERROR] $1" >&2
}

trap 'error "Script failed at line $LINENO."' ERR

log "Creating GCS bucket: $BUCKET_NAME"
gcloud storage buckets create "gs://$BUCKET_NAME" \
  --location="$LOCATION" \
  --uniform-bucket-level-access

log "Enabling bucket versioning"
gcloud storage buckets update "gs://$BUCKET_NAME" --versioning

# Create Terraform service account
log "Creating service account: $SA_NAME"
gcloud iam service-accounts create "$SA_NAME" \
  --display-name "Terraform Automation"

log "Granting Storage Admin + Viewer to service account"
gcloud projects add-iam-policy-binding "$PROJECT_ID" \
  --member="serviceAccount:$SA_EMAIL" \
  --role="roles/storage.admin"

gcloud projects add-iam-policy-binding "$PROJECT_ID" \
  --member="serviceAccount:$SA_EMAIL" \
  --role="roles/viewer"

# Create key for Terraform usage
log "Creating service account key: $KEY_FILE"
gcloud iam service-accounts keys create "$KEY_FILE" \
  --iam-account="$SA_EMAIL"

log "All commands completed successfully."

echo ""
echo "project_id:      $PROJECT_ID"
echo "bucket_name:     $BUCKET_NAME"
echo "location:        $LOCATION"
echo "sa_email:        $SA_EMAIL"
echo "key_file:        $KEY_FILE"
