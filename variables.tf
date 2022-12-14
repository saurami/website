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

variable "ssh_user" {
  type        = string
  description = "SSH user for compute instance"
  default     = "saurabh"
  sensitive   = false
}

variable "host_check" {
  type        = string
  description = "Dont add private key to known_hosts"
  default     = "-o StrictHostKeyChecking=no"
  sensitive   = false
}

variable "ignore_known_hosts" {
  type        = string
  description = "Ignore (many) keys stored in the ssh-agent; use explicitly declared keys"
  default     = "-o IdentitiesOnly=yes"
  sensitive   = false
}
