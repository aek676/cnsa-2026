variable "instance_name" {
  description = "Name of the VM instance"
  type        = string
}

variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "zone" {
  description = "GCP zone for the VM"
  type        = string
}

variable "region" {
  description = "GCP region for resources like external IPs"
  type        = string
}

variable "network_id" {
  description = "VPC network self link"
  type        = string
}

variable "subnet_id" {
  description = "Subnetwork self link"
  type        = string
}

variable "ssh_public_key" {
  description = "SSH public key for VM access"
  type        = string
}

variable "ssh_user" {
  description = "SSH username for GCP VMs"
  type        = string
}

variable "machine_type" {
  description = "GCP machine type"
  type        = string
  default     = "e2-medium"
}

variable "startup_script" {
  description = "Startup script content"
  type        = string
  default     = ""
}
