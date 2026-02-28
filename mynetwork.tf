# Para mas detalles (opocional): export TF_LOG=TRACE

# Naming module to generate consistent names for services
module "naming" {
  source  = "Azure/naming/azurerm"
  version = "0.4.3"
  suffix  = [var.org_name, var.username]
}

# Create the mynetwork network
resource "azurerm_virtual_network" "mynetwork" {
  name                = module.naming.virtual_network.name
  address_space       = ["10.0.0.0/16"]
  location            = var.resource_group_location
  resource_group_name = azurerm_resource_group.rg.name
}

# Create a subnet for the virtual machines
resource "azurerm_subnet" "subnet" {
  name                 = module.naming.subnet.name
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.mynetwork.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Create a Network Security Group with rules similar to the GCP firewall
resource "azurerm_network_security_group" "nsg" {
  name                = module.naming.network_security_group.name
  location            = var.resource_group_location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "SSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "HTTP"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Jenkins"
    priority                   = 120
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "8080"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "HTTPS"
    priority                   = 130
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# Associate the NSG with the subnet
resource "azurerm_subnet_network_security_group_association" "nsg_association" {
  subnet_id                 = azurerm_subnet.subnet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

# Create the jenkins-vm instance
module "jenkins-vm" {
  source              = "./instance"
  instance_name       = "jenkins"
  org_name            = var.org_name
  username            = var.username
  location            = var.resource_group_location
  ssh_public_key      = var.ssh_public_key
  resource_group_name = azurerm_resource_group.rg.name
  subnet_id           = azurerm_subnet.subnet.id
  admin_username      = "azureuser"
  custom_data         = base64encode(file("${path.module}/scripts/jenkins_init.sh"))
}

# Create the web-deploy-vm instance
module "web-deploy-vm" {
  source              = "./instance"
  instance_name       = "web-deploy"
  org_name            = var.org_name
  username            = var.username
  location            = var.resource_group_location
  ssh_public_key      = var.ssh_public_key
  resource_group_name = azurerm_resource_group.rg.name
  subnet_id           = azurerm_subnet.subnet.id
  admin_username      = "azureuser"
  custom_data         = base64encode(file("${path.module}/scripts/webapp_init.sh"))
}
