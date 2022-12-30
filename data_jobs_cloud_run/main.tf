# List of GCP APIs to enable in this project
locals {
  services = [
    "cloudscheduler.googleapis.com",
    "run.googleapis.com",
    "firestore.googleapis.com",
    "secretmanager.googleapis.com"
  ]
}

resource "google_project_service" "default" {
  for_each = toset(local.services)

  project = var.project_id
  service = each.value

  disable_on_destroy = false
}