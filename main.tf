locals {
  vms = {
    "jenkins"    = "jenkins_init.sh"
    "web-deploy" = "webapp_init.sh"
  }
}

module "azure_network" {
  source                  = "./azure/network-module"
  count                   = var.cloud_provider == "azure" ? 1 : 0
  resource_group_name     = azurerm_resource_group.rg[0].name
  resource_group_location = var.resource_group_location
  org_name                = var.org_name
  username                = var.username
}

module "azure_vms" {
  source              = "./azure/vms-module"
  for_each            = var.cloud_provider == "azure" ? local.vms : {}
  instance_name       = each.key
  org_name            = var.org_name
  username            = var.username
  location            = var.resource_group_location
  ssh_public_key      = var.ssh_public_key
  resource_group_name = azurerm_resource_group.rg[0].name
  subnet_id           = module.azure_network[0].subnet_id
  admin_username      = "azureuser"
  custom_data         = base64encode(file("${path.module}/scripts/${each.value}"))
}

module "gcp_network" {
  source     = "./gcp/gcp-network-module"
  count      = var.cloud_provider == "gcp" ? 1 : 0
  project_id = var.gcp_project_id
  region     = var.gcp_location
}

module "artifact_registry" {
  source        = "./gcp/artifact-registry-module"
  for_each      = var.cloud_provider == "gcp" ? { "default" = "docker-registry" } : {}
  project_id    = var.gcp_project_id
  location      = var.gcp_location
  repository_id = each.value
}

module "gcp_vms" {
  source         = "./gcp/gcp-vms-module"
  for_each       = var.cloud_provider == "gcp" ? local.vms : {}
  instance_name  = each.key
  project_id     = var.gcp_project_id
  zone           = var.gcp_zone
  region         = var.gcp_location
  network_id     = module.gcp_network[0].network_id
  subnet_id      = module.gcp_network[0].subnet_id
  ssh_public_key = var.ssh_public_key
  ssh_user       = var.username
  startup_script = file("${path.module}/scripts/${each.value}")
}
