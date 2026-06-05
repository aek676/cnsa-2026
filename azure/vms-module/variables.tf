variable "instance_name" {}
variable "location" {}
variable "resource_group_name" {}
variable "subnet_id" {}
variable "ssh_public_key" {}
variable "org_name" {}
variable "username" {}

variable "admin_username" {
  default = "azureuser"
}
variable "vm_size" {
  default = "Standard_B2s" # Equivalent to e2-medium (2 vCPU, 4 GB)
}
variable "custom_data" {
  default = ""
}
