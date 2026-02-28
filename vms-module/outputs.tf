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
