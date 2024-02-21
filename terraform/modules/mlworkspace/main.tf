data "azurerm_client_config" "current" {}
# Depend on the MLWorkspace
resource "azurerm_application_insights" "mlw_ai" {
  name                = var.app_name
  location            = var.rg_location
  resource_group_name = var.rg_name
  application_type    = var.app_type

}

resource "azurerm_key_vault" "mlw_kv" {
  name                = var.kv_name
  location            = var.rg_location
  resource_group_name = var.rg_name
  tenant_id           = var.tenant_id
  sku_name            = var.kv_sku
}

resource "azurerm_storage_account" "mlw_sa" {
  name                     = var.sa_name
  location                 = var.rg_location
  resource_group_name      = var.rg_name
  account_tier             = var.sa_tier
  account_replication_type = var.sa_rt
}

resource "azurerm_machine_learning_workspace" "demoml" {
  name                    = var.mlw_name
  location                = var.rg_location
  resource_group_name     = var.rg_name
  application_insights_id = azurerm_application_insights.mlw_ai.id
  key_vault_id            = azurerm_key_vault.mlw_kv.id
  storage_account_id      = azurerm_storage_account.mlw_sa.id
  identity {
    type = "SystemAssigned"
  }
}
## Private Endpoint Configuration
resource "azurerm_private_endpoint" "kv_ple" {
  name                = "ple-${var.kv_name}-kv"
  location            = var.rg_location
  resource_group_name = var.rg_name
  subnet_id           = var.subnet_mlw

  private_service_connection {
    name                           = "psc-${var.kv_name}-kv"
    private_connection_resource_id = azurerm_key_vault.mlw_kv.id
    subresource_names              = ["vault"]
    is_manual_connection           = false
  }
}

resource "azurerm_private_endpoint" "sa_ple_blob" {
  name                = "ple-${var.sa_name}-sa-blob"
  location            = var.rg_location
  resource_group_name = var.rg_name
  subnet_id           = var.subnet_mlw

  private_service_connection {
    name                           = "psc-${var.sa_name}-sa"
    private_connection_resource_id = azurerm_storage_account.mlw_sa.id
    subresource_names              = ["blob"]
    is_manual_connection           = false
  }
}
resource "azurerm_private_endpoint" "mlw-pe" {
  name                = "ws-private"
  location            = var.rg_location
  resource_group_name = var.rg_name
  subnet_id           = var.subnet_mlw
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
# Machine Learning Cluster
# resource "azurerm_machine_learning_compute_cluster" "demo-mlc" {
#   name                          = var.mlc_name
#   location                      = var.rg_location
#   vm_priority                   = var.mlc_vm_priority
#   vm_size                       = var.mlc_vm_size
#   machine_learning_workspace_id = azurerm_machine_learning_workspace.demoml.id
#   subnet_resource_id            = var.subnet_mlc

#   scale_settings {
#     min_node_count                       = 0
#     max_node_count                       = 1
#     scale_down_nodes_after_idle_duration = "PT30S" # 30 seconds
#   }

# }
# MLInstance
resource "azurerm_machine_learning_compute_instance" "demo-mli" {
  name                          = "demomli"
  location                      = var.rg_location
  machine_learning_workspace_id = azurerm_machine_learning_workspace.demoml.id
  virtual_machine_size          = "STANDARD_DS2_V2"
  authorization_type            = "personal"
  ssh {
    public_key = file(var.ssh_key)
  }
  subnet_resource_id = var.subnet_mli
  depends_on = [azurerm_private_endpoint.mlw-pe]
}
