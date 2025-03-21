variable "instance_name" {}
variable "location" {}
variable "resource_group_name" {}
variable "subnet_id" {}
variable "admin_username" {
  default = "azureuser"
}
variable "vm_size" {
  default = "Standard_B2s" # Equivalent to e2-medium (2 vCPU, 4 GB)
}
variable "custom_data" {
  default = ""
}

data "azurerm_client_config" "current" {}

# Create public IP address
resource "azurerm_public_ip" "public_ip" {
  name                = "${var.instance_name}-public-ip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Dynamic"
  domain_name_label   = "${var.instance_name}-${substr(data.azurerm_client_config.current.client_id, 0, 6)}"
}

# Create network interface
resource "azurerm_network_interface" "nic" {
  name                = "${var.instance_name}-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "public"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip.id
  }
}

# Create Linux Virtual Machine
resource "azurerm_linux_virtual_machine" "vm" {
  name                = var.instance_name
  location            = var.location
  resource_group_name = var.resource_group_name
  size                = var.vm_size
  admin_username      = var.admin_username
  network_interface_ids = [
    azurerm_network_interface.nic.id,
  ]

  admin_ssh_key {
    username   = var.admin_username
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    disk_size_gb         = 30
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  custom_data = var.custom_data
}

output "instance_ip_addr" {
  value       = azurerm_public_ip.public_ip.ip_address
  description = "The public IP address of the VM instance."
}


output "instance_dns" {
  value       = azurerm_public_ip.public_ip.domain_name_label
  description = "The public DNS of the VM instance."
}

output "instance_name" {
  value       = var.instance_name
  description = "The name of the VM instance."
}
