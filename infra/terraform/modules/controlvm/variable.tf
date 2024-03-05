# Resoure group
variable "rg_name" {
  description = "The name of the Resource Group"
  type = string
}
variable "rg_location" {
  description = "The Resource Group location"
  type = string
}
# Network
variable "vnet_subnet_id" {
  description = "The AKS Controlplane's subnet"
  type = string
}
variable "publicip_id" {
  description = "The public IP for access throughout ssh key"
  type = map(string)
}
# VM
variable "VM_conf" {
    description = "The configuration of the VM"
    type = map(string)
    default = {
        "name" = "jumhost_vm"
        "size" = "Standard_B2s"
        "tags" = "system-app"
        "os_disk_size_gb" = 30
        "os_type" = "Linux" 
    }
}
variable "control_vm_map" {
  description = "The defination of control VM list"
  type = object({
    jpvm = map(string)
    dsvm = map(string)
  })
}
variable "admin_username" {
  description = "Admin username for the VM"
  type        = string
}

variable "ssh_key" {
  description = "SSH public key for authentication"
}
