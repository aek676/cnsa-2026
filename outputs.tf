output "vms" {
  value = { for k, v in module.vms : k => {
    hostname  = v.instance_name
    public_ip = v.instance_ip_addr
    dns       = v.instance_dns
    }
  }
}

output "artifact_registry" {
  value = {
    repository_id  = module.artifact_registry.repository_id
    repository_url = module.artifact_registry.repository_url
    id             = module.artifact_registry.id
  }
}
