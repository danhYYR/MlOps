# Resoure group
variable "rg_name" {
  description = "The name of the Resource Group"
  type = string
}
variable "rg_location" {
  description = "The Resource Group location"
  type = string
}
# Inbound Port
variable "nsg-ports" {
    type = list(number)
}
