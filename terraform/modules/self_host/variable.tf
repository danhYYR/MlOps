# Resoure group
variable "rg_name" {
  description = "The name of the Resource Group"
  type        = string
}
variable "rg_location" {
  description = "The Resource Group location"
  type        = string
}
# Private Endpoint
## DNS zone
variable "dns_aml_id" {
  description = "The ID DNS private zone of the Azure Machine learning"
  type = string
}
variable "dns_notbook_id" {
  description = "The ID DNS private zone of the Azure Machine learning Notebook"
  type = string
}
variable "mlw_id" {
    description = "The Machine Learning workspace resource ID"
    type = string
}
## Self host subnet
variable "subnet_sh" {
    description = "The subnet ID of self host agent"
    type = string
}
# Jumphost VM
variable "jumphost_data" {
  description = "The output of jumphost VM"
  type = object({
    hostname = string
    username = string
    ssh_key  = string
  })
}