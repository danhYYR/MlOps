# Resoure group
variable "tenant_id" {
  description = "The Tenant ID of your organiztion"
  type        = string
  default     = "Fill your organization ID in"
}
variable "rg_name" {
  description = "The name of the Resource Group"
  type        = string
  default     = "demogrptf"
}
variable "rg_location" {
  description = "The Resource Group location"
  type        = string
  default     = "centralindia"
}
variable "enviroment" {
  description = "The enviroment defination"
  type        = string
  default     = "test"
}
# Vnet
variable "Vnet_Workspace" {
  description = "The Virtual Network defination for workspace components"
  type = object({
    address_prefixes = list(string)
    subnet = object({
      aks_control = list(string)
      aks_node    = list(string)
      jumphost_vm = list(string)
      mlc         = list(string)
      mli         = list(string)
    })
  })
}
variable "Vnet_DB" {
  description = "The Storage components VNet"
  type = object({
    address_prefixes = list(string)
    subnet = object({
      ai = list(string)
      sa = list(string)
      kv = list(string)
      cr = list(string)
    })
  })
}
# AKS variable
variable "aks_name" {
  description = "The AKS Cluster's Name"
  type        = string
  default     = "demoaks"
}
# JumpHost VM
variable "admin_username" {
  description = "Admin username for the VM"
  type        = string
  default     = "admin"
}
variable "ssh_key" {
  description = "SSH public key for authentication"
}
# Service Principal
variable "sp_id" {
  description = "The Service Principal from Pipeline"
  default     = "Fill in with your service principal ID"
}
variable "sp_secret" {
  description = "The Service Principal secret from Pipeline"
  default     = "Fill in with your service principal password"
}
# Machine Learning Workspace
variable "mlw_name" {
  description = "The name for Machine Learning Workspace"
  type        = string
  default     = "demo-mlops"
}
variable "application_insight" {
  description = "The defination for application insight"
  type = object({
    name = string
    type = string
  })
}
variable "keyvault" {
  description = "The Keyvault Defination"
  type = object({
    name     = string
    sku_name = string
  })
}
variable "storage_account" {
  description = "The storage account object"
  type = object({
    name             = string
    tier             = string
    replication_type = string
  })
}
## Machine Learning Cluster
variable "mlc_name" {
  description = "The name of machine learning cluster"
  default     = "mlops-cluster"
}
variable "mlc_vm_size" {
  description = "The size of VM"
  default     = "Standard_DS2_v2"
}
variable "mlc_vm_priority" {
  description = "The priority of VM"
  default     = "LowPriority"
}
