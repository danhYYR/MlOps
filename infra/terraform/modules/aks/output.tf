output "aks_id" {
  description = "The AKS ids"
  value = azurerm_kubernetes_cluster.aks_cluster.id
}
output "aks-group" {
  description = "The group deploy node pool"
  value = azurerm_kubernetes_cluster.aks_cluster.node_resource_group
}
output "kubernetes_version" {
    description = "The latest version of kubernetes"
    value = data.azurerm_kubernetes_service_versions.current.latest_version
  
}