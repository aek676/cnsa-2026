terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
    google = {
      source  = "hashicorp/google"
      version = "~> 7.0"
    }
  }
}

provider "azurerm" {
  features {}
}

provider "google" {
  project = var.gcp_project_id
}

resource "azurerm_resource_group" "rg" {
  count    = var.cloud_provider == "azure" ? 1 : 0
  name     = var.resource_group_name
  location = var.resource_group_location
}
