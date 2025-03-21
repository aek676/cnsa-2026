# Variables will be loaded from environment variables with TF_VAR_ prefix
variable "azure_subscription_id" {
  description = "Azure Subscription ID"
}

variable "azure_tenant_id" {
  description = "Azure Tenant ID"
}

variable "azure_client_id" {
  description = "Azure Client ID"
}

variable "azure_client_secret" {
  description = "Azure Client Secret"
  sensitive   = true
}

variable "resource_group_location" {
  description = "Location of the resource group"
  default     = "eastus" # This default will be overridden by the env variable if present
}

variable "resource_group_name" {
  description = "Name of the resource group"
  default     = "cnsa-2024-rg" # This default will be overridden by the env variable if present
}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = var.azure_subscription_id
  tenant_id       = var.azure_tenant_id
  client_id       = var.azure_client_id
  client_secret   = var.azure_client_secret
}

# Resource group 
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.resource_group_location
}
