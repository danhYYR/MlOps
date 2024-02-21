data "azurerm_kubernetes_service_versions" "current" {
    location = var.rg_location
    include_preview = false
}
resource "azurerm_kubernetes_cluster" "aks_cluster" {
    name = var.aks_name
    location = var.rg_location
    resource_group_name = var.rg_name
    kubernetes_version = data.azurerm_kubernetes_service_versions.current.latest_version
    default_node_pool {
        name = lookup(var.default_vm, "name", "default_vm")
        node_count = 2
        vm_size = lookup(var.default_vm,"vmsize","Standard_B1s")
        vnet_subnet_id = var.subnet_node
    }

    dns_prefix = "demo-example"
    # identity {
    #     type = "SystemAssigned"
    # }
    network_profile {
        network_plugin = "azure"
        load_balancer_sku = "standard"
    }
    service_principal {
      client_id = var.client_id
      client_secret = var.client_secret
    }
    api_server_access_profile {
        vnet_integration_enabled = true
        subnet_id = var.subnet_cp
    }
    private_cluster_enabled = true

}