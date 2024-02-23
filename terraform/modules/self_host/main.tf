resource "azurerm_private_endpoint" "mlw-sh-pe" {
  name                = "mlw-sh-pe"
  location            = var.rg_location
  resource_group_name = var.rg_name
  subnet_id           = var.subnet_sh
  private_service_connection {
    name                           = "${azurerm_machine_learning_workspace.demoml.name}-pe"
    private_connection_resource_id = azurerm_machine_learning_workspace.demoml.id
    is_manual_connection           = false
    subresource_names              = ["amlworkspace"]
  }
    private_dns_zone_group {
    name                 = "private-dns-zone-group"
    private_dns_zone_ids = [var.dns_aml_id, var.dns_notbook_id]
  }
}

# resource "null_resource" "inventory_config" {
#   provisioner "local-exec" {
#     command = " "
#   }
# }