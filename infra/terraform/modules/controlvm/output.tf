output "admin_username" {
  description = "The admin user of the control VMs"
  value       = var.admin_username
}
locals {
  ssh_key = regex("(\\S*).pub", var.ssh_key)[0] # Beacause the output of regex is tuple
}
# Output jumphost information to a file (securely store this file)
output "linux_vm_data" {
  value = {
    for vm_name,vm_conf in azurerm_linux_virtual_machine.linux_vm:  
      vm_name =>{
        vmname = vm_conf.name
        hostname = vm_conf.public_ip_address
        username = vm_conf.admin_username
        ssh_key  = local.ssh_key
      }
  }
}
output "windows_vm_data" {
  value = {
    for vm_name,vm_conf in azurerm_windows_virtual_machine.windows_vm:  
      vm_name =>{
        vmname = vm_conf.name
        hostname = vm_conf.public_ip_address
        username = vm_conf.admin_username
        password = vm_conf.admin_password
        ssh_key  = local.ssh_key
      }
  }
}
