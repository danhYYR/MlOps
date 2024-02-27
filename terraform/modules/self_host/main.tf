resource "azurerm_private_endpoint" "mlw-sh-pe" {
  name                = "mlw-sh-pe"
  location            = var.rg_location
  resource_group_name = var.rg_name
  subnet_id           = var.subnet_sh
  private_service_connection {
    name                           = "sh-pe"
    private_connection_resource_id = var.mlw_id
    is_manual_connection           = false
    subresource_names              = ["amlworkspace"]
  }
    private_dns_zone_group {
    name                 = "private-dns-zone-group"
    private_dns_zone_ids = [var.dns_aml_id, var.dns_notbook_id]
  }
}
// Prepare Ansible Inventory
resource "local_file" "inventory_variable" {
  filename = "${path.cwd}/${path.module}/variable_file.yml"
  content  = local.ansible_vars
}
resource "null_resource" "inventory_config" {
  provisioner "local-exec" {
    command = <<-EOT
      ${local.ansible_workspace}
      ${local.ansible_cmd}
    EOT
  }
  triggers = {always_run = timestamp()}
  depends_on = [local_file.inventory_variable]
}