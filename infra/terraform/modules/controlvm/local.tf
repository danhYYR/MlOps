# Get Public IP
locals {
  jp_ip = lookup(var.publicip_id,"jpvm","none")
  ds_ip =  lookup(var.publicip_id,"dsvm","none")
}
# Get name (key) of the VM
locals {
    vm_name_list = keys(var.control_vm_map)
}
# Mapping NIC to vm
locals {
  nic_ids = {
    for i,nic in azurerm_network_interface.vm_nic:
    nic.name => nic.id
  }
}
