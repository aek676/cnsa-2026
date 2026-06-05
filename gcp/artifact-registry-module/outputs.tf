output "repository_id" {
  description = "The ID of the created repository"
  value       = google_artifact_registry_repository.this.repository_id
}

output "repository_url" {
  description = "The URL of the repository"
  value       = google_artifact_registry_repository.this.registry_uri
}

output "id" {
  description = "The ID of the created repository"
  value       = google_artifact_registry_repository.this.id
}
