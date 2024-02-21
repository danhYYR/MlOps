# Organization
variable "tenant_id" {
  description = "The tennent ID from the Azure Account"
  type        = string
}
# Resoure group
variable "rg_name" {
  description = "The name of the Resource Group"
  type        = string
}
variable "rg_location" {
  description = "The Resource Group location"
  type        = string
}
# MLWorkspace dependencies
## Application Insight
variable "app_name" {
  description = "The Application Insight's name"
  type        = string
}
variable "app_type" {
  description = "The type of the application insight"
  type        = string
}
## Keyvault
variable "kv_name" {
  description = "The name of the key vault"
  type        = string
}
variable "kv_sku" {
  description = "the SKU of the Keyvault"
  type        = string
}
## Storage account
variable "sa_name" {
  description = "The Storage account's name"
  type        = string
}
variable "sa_tier" {
  description = "The tier of storage account"
  type        = string
}
variable "sa_rt" {
  description = "Replication option for storage account"
  type        = string
}
## Machine Learning Workspace
variable "mlw_name" {
  description = "The machine learning workspace's name"
  type        = string
}
variable "subnet_mlw" {
  description = "The Subnet ID of the Administator"
  type = string
}
variable "dns_aml_id" {
  description = "The ID DNS private zone of the Azure Machine learning"
  type = string
}
variable "dns_notbook_id" {
  description = "The ID DNS private zone of the Azure Machine learning Notebook"
  type = string
}
# Machine Learning Cluster
variable "mlc_name" {
  description = "The name of machine learning cluster"
  type        = string
}
variable "mlc_vm_size" {
  description = "The size of VM"
  type        = string
}
variable "mlc_vm_priority" {
  description = "The priority of VM"
  type        = string
}

# Machine Learning Instance
variable "subnet_mli" {
  description = "The ID of machine learning instance subnet"
  type = string
}
variable "ssh_key" {
  description = "The path of the ssh key"
  type = any
}