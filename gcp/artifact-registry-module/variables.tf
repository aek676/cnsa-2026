variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "location" {
  description = "GCP location/region for the repository"
  type        = string
}

variable "repository_id" {
  description = "The ID of the repository"
  type        = string
  default     = "docker-registry"
}

variable "description" {
  description = "Description of the repository"
  type        = string
  default     = "Docker repository"
}

variable "format" {
  description = "Format of the repository (DOCKER, NPM, PYTHON, etc.)"
  type        = string
  default     = "DOCKER"
}

variable "labels" {
  description = "Labels to apply to the repository"
  type        = map(string)
  default     = {}
}

variable "mode" {
  description = "Repository mode (STANDARD_REPOSITORY or VIRTUAL_REPOSITORY)"
  type        = string
  default     = "STANDARD_REPOSITORY"
}
