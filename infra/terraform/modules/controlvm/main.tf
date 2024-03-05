resource "azurerm_network_interface" "vm_nic" {
  for_each = {for vm_name,ip_id in var.publicip_id: vm_name => ip_id}
  name                = "${each.key}-nic"
  resource_group_name = var.rg_name
  location            = var.rg_location

  ip_configuration {
    name                          = "${each.key}-ip-config"
    subnet_id                     = var.vnet_subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = each.value
  }
}
resource "azurerm_linux_virtual_machine" "linux_vm" {
  for_each              = { for vm_name, vm_conf in var.control_vm_map : vm_name => vm_conf if vm_conf["os_type"] == "linux" }
  resource_group_name   = var.rg_name
  location              = var.rg_location
  name                  = each.value["vm_name"]
  size                  = each.value["vm_size"]
  admin_username        = var.admin_username
  network_interface_ids = [azurerm_network_interface.vm_nic[each.key].id]
  admin_ssh_key {
    username   = var.admin_username
    public_key = file(var.ssh_key)
  }
  os_disk {
    name                 = each.value["os_disk_name"]
    caching              = each.value["os_disk_caching"]
    storage_account_type = each.value["os_disk_type"]
  }
  source_image_reference {
    publisher = each.value["image_publisher"]
    offer     = each.value["image_offer"]
    sku       = each.value["image_sku"]
    version   = each.value["image_version"]
  }
  ### Auto run script
}
resource "azurerm_virtual_machine_extension" "install_kubectl" {
  for_each = {for vm in azurerm_linux_virtual_machine.linux_vm: vm.name =>vm.id}
  name                 = "install-kubectl"
  virtual_machine_id   = each.value
  publisher            = "Microsoft.Azure.Extensions"
  type                 = "CustomScript"
  type_handler_version = "2.1"
  protected_settings   = <<PROTECTED_SETTINGS
    {
      "script": "${base64encode(file("${path.module}/scripts/install.sh"))}" 
    }
PROTECTED_SETTINGS
}
resource "azurerm_windows_virtual_machine" "windows_vm" {
  for_each              = { for vm_name, vm_conf in var.control_vm_map : vm_name => vm_conf if vm_conf["os_type"] == "windows" }
  resource_group_name   = var.rg_name
  location              = var.rg_location
  name                  = each.value["vm_name"]
  size                  = each.value["vm_size"]
  network_interface_ids = [azurerm_network_interface.vm_nic[each.key].id]
  admin_username        = var.admin_username
  admin_password        = each.value["os_profile_password"]
  os_disk {
    name                 = each.value["os_disk_name"]
    caching              = each.value["os_disk_caching"]
    storage_account_type = each.value["os_disk_type"]
  }
  source_image_reference {
    publisher = each.value["image_publisher"]
    offer     = each.value["image_offer"]
    sku       = each.value["image_sku"]
    version   = each.value["image_version"]
  }
}
