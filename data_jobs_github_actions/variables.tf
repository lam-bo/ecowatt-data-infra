

variable "project_id" {
  type        = string
  description = "The Google Cloud project id"
  default     = "ecowatt-data-v2"
}

variable "region" {
  type        = string
  description = "The default region used for resources created"
  default     = "us-central1"
}

variable "data_jobs_git_repo" {
  type        = string
  description = "The org/repo of the Github code repository for the data jobs tasks"
  default = "lam-bo/ecowatt-data-jobs"
}