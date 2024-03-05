output name {
  description = "Specifies the name of the virtual network"
  value       = azurerm_virtual_network.demovnet_workspace.name
}
output vnet_ws_id {
  description = "Specifies the resource id of the virtual network"
  value       = azurerm_virtual_network.demovnet_workspace.id
}
output publicip_id{
    description = "The pulic IP id map for list VM"
    value = {for i,vm in var.list_vm : vm =>azurerm_public_ip.demovnet_pulicIP[i].id}
}
# AKS-Subnet
output cp_subnet_id {
  description = "The Vnet to manage the Control Plane on AKS"
  value = azurerm_subnet.aks-cp.id
}
output node_subnet_id {
  description = "The Cluster subnet for AKS"
  value = azurerm_subnet.aks-node.id
}
output "jp_subnet_id" {
  description = "The Cluster subnet for AKS"
  value = azurerm_subnet.jp_vm.id  
}
# Machine Learning Workspace Subnet
output mlw_subnet_id {
  description = "The subnet for Machine Learning Cluster"
  value = azurerm_subnet.mlc.id
}
output "mli_subnet_id" {
  description = "The subnet for Machine Learning Instance"
  value = azurerm_subnet.mli.id
}
## DNS Private zone
output "dns_aml_id" {
  description = "The DNS private zone's ID of the Azure Machine Learning"
  value = azurerm_private_dns_zone.dnsazureml.id
}
output "dns_notbook_id" {
  description = "The ID DNS private zone of Azure Machine Learning Notebook"
  value = azurerm_private_dns_zone.dnsnotebooks.id
}
