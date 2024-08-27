variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "region" {
  description = "The region where resources will be created"
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "The zone where the VM will be deployed"
  type        = string
  default     = "us-central1-a"
}

variable "db_password" {
  description = "Password for the Cloud SQL database"
  type        = string
  sensitive   = true
}
