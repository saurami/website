variable "project_id" {
  type        = string
  description = "Auto-generated GCP project ID"
  nullable    = false
  sensitive   = true
}

variable "account_id" {
  type        = string
  description = "Service account ID - one of its name, fully-qualified path, or email address"
  nullable    = false
  sensitive   = true
}
