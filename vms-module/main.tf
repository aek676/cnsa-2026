module "naming" {
  source  = "Azure/naming/azurerm"
  version = "0.4.3"
  suffix  = [var.org_name, var.instance_name]
}

data "azurerm_client_config" "current" {}

# Create public IP address
resource "azurerm_public_ip" "public_ip" {
  name                = module.naming.public_ip.name
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  domain_name_label   = "${var.instance_name}-${substr(data.azurerm_client_config.current.client_id, 0, 6)}"
}

# Create network interface
resource "azurerm_network_interface" "nic" {
  name                = module.naming.network_interface.name
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
  name                = module.naming.linux_virtual_machine.name
  location            = var.location
  resource_group_name = var.resource_group_name
  size                = var.vm_size
  admin_username      = var.admin_username
  network_interface_ids = [
    azurerm_network_interface.nic.id,
  ]

  admin_ssh_key {
    username   = var.admin_username
    public_key = var.ssh_public_key
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
