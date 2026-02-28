output "vms" {
  value = { for k, v in module.vms : k => {
    hostname  = v.instance_name
    public_ip = v.instance_ip_addr
    dns       = v.instance_dns
  } }
}
