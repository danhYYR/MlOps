# Resoure group
variable "rg_name" {
  description = "The name of the Resource Group"
  type = string
}
variable "rg_location" {
  description = "The Resource Group location"
  type = string
}
# Virtual network
variable "vnet_wokspace_address" {
  description = "Workspace Vnet range"
  type = list(string)
}
## AKS Subnet
variable "aks_cp_address" {
  description = "The AKS Control Plane Subnet"
  type = list(string)
}
variable "aks_node_address" {
  description = "Subnet address of the AKS Node"
  type = list(string)
}
## JumpHost VM
variable "jp_vm_address" {
  description = "The subnet address of Jump Host VM"
  type = list(string)
}
## Machine Learning Workspace
variable "mlc_address" {
  description = "The Machine Learning Cluster's address space"
  type = list(string)
}
variable "mli_address" {
  description = "The Machine Learning Instace's address space"
  type = list(string)
}