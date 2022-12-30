output "DATA_JOBS_GITHUB_SERVICE_ACCOUNT" {
  value       = google_service_account.data_jobs_github_actions.email
  description = "Service account to use in GitHub Action for federated auth in data jobs project"
}

output "DATA_JOBS_GITHUB_IDENTITY_PROVIDER" {
  value       = google_iam_workload_identity_pool_provider.data_jobs_github_actions.name
  description = "Provider ID to use in Auth action for GCP in GitHub for data jobs project"
}

output "DATA_JOBS_REGISTRY_BASE_URL" {
  value       = "${var.region}-docker.pkg.dev"
  description = "Artifact Registry base url for data jobs tasks"
}

output "DATA_JOBS_REGISTRY_IMAGE_PATH" {
  value       = "${data.google_project.project.project_id}/${google_artifact_registry_repository.data_jobs.name}"
  description = "Artifact Registry path for data jobs tasks"
}


