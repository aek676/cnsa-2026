output "instance_name" {
  description = "The name of the VM instance"
  value       = google_compute_instance.vm.name
}

output "instance_external_ip" {
  description = "The external IP address of the VM instance"
  value       = google_compute_address.external_ip.address
}

output "instance_internal_ip" {
  description = "The internal IP address of the VM instance"
  value       = google_compute_instance.vm.network_interface[0].network_ip
}

output "ssh_user" {
  description = "SSH username for this VM"
  value       = var.ssh_user
}
