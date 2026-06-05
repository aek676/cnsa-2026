output "azure_vms" {
  value = var.cloud_provider == "azure" ? { for k, v in module.azure_vms : k => {
    hostname  = v.instance_name
    public_ip = v.instance_ip_addr
    dns       = v.instance_dns
    }
  } : {}
}

output "gcp_vms" {
  value = var.cloud_provider == "gcp" ? { for k, v in module.gcp_vms : k => {
    hostname    = v.instance_name
    external_ip = v.instance_external_ip
    internal_ip = v.instance_internal_ip
    ssh_user    = v.ssh_user
    }
  } : {}
}

output "artifact_registry" {
  value = var.cloud_provider == "gcp" ? {
    repository_id  = try(module.artifact_registry[0].repository_id, "")
    repository_url = try(module.artifact_registry[0].repository_url, "")
    id             = try(module.artifact_registry[0].id, "")
  } : {}
}

output "debug_gcp_project_id" {
  value = var.gcp_project_id
}
