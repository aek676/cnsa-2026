variable "resource_group_location" {
  description = "Location of the resource group"
  type        = string
  default     = "eastus" # This default will be overridden by the env variable if present
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "cnsa-2024-rg" # This default will be overridden by the env variable if present
}

variable "ssh_public_key" {
  description = "SSH public key for VM access"
  type        = string
  default     = ""
}
