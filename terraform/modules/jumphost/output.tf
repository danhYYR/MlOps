output "admin_username" {
  description = "The admin user of the jumphost machine"
  value       = azurerm_linux_virtual_machine.jp_vm.admin_username
}
locals {
  ssh_key = split(".", var.ssh_key)[0]
}
# Output jumphost information to a file (securely store this file)
output "jumphost_data" {
    value = {
        hostname = azurerm_linux_virtual_machine.jp_vm.name
        username = azurerm_linux_virtual_machine.jp_vm.admin_username
        ssh_key  = local.ssh_key
    }

}
