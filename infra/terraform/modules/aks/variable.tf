variable "rg_name" {
  description = "The name of the resource group which created by terraform"
  type = string
}
variable "rg_location" {
    description = "The location which will be hosted the AKS cluster"
    type = string
}
variable "aks_name" {
    description = "The AKS Cluster's Name"
    type = string
}
variable "default_vm" {
  type = map(string)
  default = {
    "name" = "defaultpool"
    "vmsize" = "Standard_D2_v2"
    "tags" = "system-app"
    "os_disk_size_gb" = 30
    "os_type" = "Linux" 
  } 
}
# Custom Vnet
variable "subnet_cp" {
  type = string
}
variable "subnet_node" {
  type = string
}
# Service Principal
variable "client_id" {
  description = "The client Id from Service Principal"
  type = string
}
variable "client_secret" {
  description = "The Password of Service Princinpal"
  type = string
}