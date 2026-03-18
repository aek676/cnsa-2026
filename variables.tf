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
  description = "GCP project ID for Artifact Registry"
  type        = string
}

variable "gcp_location" {
  description = "GCP location for Artifact Registry"
  type        = string
  default     = "us-central1"
}

