

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

variable "firestore_location" {
  type        = string
  description = "The location used for firestore database"
  default     = "us-central"
}