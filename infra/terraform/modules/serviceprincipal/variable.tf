# Vnet
## Cluster Vnet
variable "rg_id" {
    description = "The ID for the Resource group for assigned all resource on this one"
    type = string
}
## Vnet for AKS
variable "vnet_id" {
  description = "The ID for the Vnet assigned cluster"
  type = string
}
# Service Principal
variable "sp_name" {
    description = "The name of Service Pricipal"
    type = string
}
variable "sp_id" {
    description = "The Service Principal Object ID"
    type = string
}