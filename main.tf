locals {
  vms = {
    "jenkins"    = "jenkins_init.sh"
    "web-deploy" = "webapp_init.sh"
  }
}

module "vms" {
  source              = "./vms-module"
  for_each            = local.vms
  instance_name       = each.key
  org_name            = var.org_name
  username            = var.username
  location            = var.resource_group_location
  ssh_public_key      = var.ssh_public_key
  resource_group_name = azurerm_resource_group.rg.name
  subnet_id           = azurerm_subnet.subnet.id
  admin_username      = "azureuser"
  custom_data         = base64encode(file("${path.module}/scripts/${each.value}"))
}

module "artifact_registry" {
  source        = "./artifact-registry-module"
  project_id    = var.gcp_project_id
  location      = var.gcp_location
  repository_id = "docker-registry"
}
