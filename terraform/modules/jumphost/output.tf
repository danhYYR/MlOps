output "admin_username" {
    description = "The admin user of the jumphost machine"
    value = azurerm_linux_virtual_machine.jp_vm.admin_username
}