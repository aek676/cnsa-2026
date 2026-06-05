variable "cloud_provider" {
  description = "Cloud provider to deploy (azure or gcp)"
  type        = string
  validation {
    condition     = contains(["azure", "gcp"], var.cloud_provider)
    error_message = "cloud_provider must be 'azure' or 'gcp'."
  }
}

variable "resource_group_location" {
  description = "Location of the resource group"
  type        = string
  default     = "eastus"
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "cnsa-2024-rg"
}

variable "org_name" {
  description = "Organization name"
  type        = string
  default     = "cnsa"
}

variable "username" {
  description = "Username for VM access"
  type        = string
}
variable "ssh_public_key" {
  description = "SSH public key for VM access"
  type        = string
  default     = ""
}

variable "gcp_project_id" {
  description = "GCP project ID"
  type        = string
}

variable "gcp_location" {
  description = "GCP location/region"
  type        = string
  default     = "us-central1"
}

variable "gcp_zone" {
  description = "GCP zone for VM instances"
  type        = string
  default     = "us-central1-a"
}

