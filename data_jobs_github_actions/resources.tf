
# GCR registry
resource "google_artifact_registry_repository" "data_jobs" {
  provider = google-beta
  project = var.project_id

  description = "Registry for data jobs images"
  location = var.region
  repository_id = "data-jobs"
  format = "DOCKER"
}

# Service account to be used for federated auth to connect to GCR
resource "google_service_account" "data_jobs_github_actions" {
  account_id   = "data-jobs-ghub-actions-user"
  display_name = "Data jobs service account impersonated in GitHub Actions"
}

# Role binding to allow publisher to publish images
resource "google_artifact_registry_repository_iam_member" "data_jobs_github_actions" {
  provider   = google-beta
  project    = var.project_id
  location   = var.region
  repository = google_artifact_registry_repository.data_jobs.name
  role       = "roles/artifactregistry.writer"
  member     = "serviceAccount:${google_service_account.data_jobs_github_actions.email}"
}

# Identiy pool for GitHub action based identity's access to Google Cloud resources
resource "google_iam_workload_identity_pool" "data_jobs_github_actions" {
  provider                  = google-beta
  workload_identity_pool_id = "data-jobs-ghub-actions-pool"
}

# Configuration for GitHub identity provider
resource "google_iam_workload_identity_pool_provider" "data_jobs_github_actions" {
  provider                           = google-beta
  workload_identity_pool_id          = google_iam_workload_identity_pool.data_jobs_github_actions.workload_identity_pool_id
  workload_identity_pool_provider_id = "data-jobs-ghub-actions-provider"
  attribute_mapping = {
    "google.subject"       = "assertion.sub"
    "attribute.aud"        = "assertion.aud"
    "attribute.actor"      = "assertion.actor"
    "attribute.repository" = "assertion.repository"
  }
  oidc {
    issuer_uri        = "https://token.actions.githubusercontent.com"
    allowed_audiences = []
  }
}

# IAM policy bindings to the service account resources created by GitHub identify
resource "google_service_account_iam_member" "data_jobs_pool_impersonation" {
  provider           = google-beta
  service_account_id = google_service_account.data_jobs_github_actions.id
  role               = "roles/iam.workloadIdentityUser"
  member             = "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.data_jobs_github_actions.name}/attribute.repository/${var.data_jobs_git_repo}"
}