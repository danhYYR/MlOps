resource "azurerm_network_interface" "jump_host_nic" {
  name                = "jump-host-nic"
  resource_group_name = var.rg_name
  location            = var.rg_location
  
  ip_configuration {
    name                          = "jump-host-ip-config"
    subnet_id                     = var.vnet_subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = var.publicip_id
  }
}
resource "azurerm_linux_virtual_machine" "jp_vm" {
    name = "jumhostvm"
    resource_group_name = var.rg_name
    location = var.rg_location
    size = lookup(var.VM_conf,"size","Standard_B1s")
    admin_username = var.admin_username
    admin_ssh_key {
      username = var.admin_username
      public_key = file(var.ssh_key)
    }
    network_interface_ids = [azurerm_network_interface.jump_host_nic.id]
    os_disk {
        caching              = "ReadWrite"
        storage_account_type = "Premium_LRS"
    }
    source_image_reference {
        publisher = "Canonical"
        offer     = "0001-com-ubuntu-server-jammy"
        sku       = "22_04-lts"
        version   = "latest"
    }
    ### Auto run script
}
resource "azurerm_virtual_machine_extension" "install_kubectl" {
  name                 = "install-kubectl"
  virtual_machine_id   = azurerm_linux_virtual_machine.jp_vm.id
  publisher            = "Microsoft.Azure.Extensions"
  type                 = "CustomScript"
  type_handler_version = "2.1"
  protected_settings = <<PROTECTED_SETTINGS
    {
      "script": "${base64encode(file("${path.module}/scripts/install.sh"))}" 
    }
PROTECTED_SETTINGS
}
