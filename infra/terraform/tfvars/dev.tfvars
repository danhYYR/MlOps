### Start ###
# Resource group
rg_name     = "demomlops"
rg_location = "eastasia"
enviroment  = "dev"
### STOP EXPORT ###
# Vnet define
Vnet_Workspace = {
  address_prefixes = ["172.0.0.0/16"]
  subnet = {
    aks_control = ["172.0.0.0/24"]
    aks_node    = ["172.0.244.0/24"]
    jumphost_vm = ["172.0.5.0/24"]
    mli         = ["172.0.10.0/24"]
    mlc         = ["172.0.50.0/24"]
  }
}
Vnet_DB = {
  address_prefixes = ["10.0.0.0/16"]
  subnet = {
    ai = ["10.0.0.0/24"]
    sa = ["10.0.244.0/24"]
    kv = ["10.0.5.0/24"]
    cr = ["10.0.10.0/24"]
  }
}
# Aks define
aks_name = "aks-demo"
# Control VM define
control_vm_map = {
  jpvm = {
    vm_name        = "jumphost"
    vm_size        = "Standard_B2s"
    delete_os_disk = "true"
    // Image
    image_publisher = "Canonical"
    image_offer     = "0001-com-ubuntu-server-jammy"
    image_version   = "latest"
    image_sku       = "22_04-lts-gen2"
    // OS config
    os_disk_name    = "JP_OsDisk_123"
    os_disk_caching = "ReadWrite"
    os_disk_create  = "FromImage"
    os_disk_type    = "Standard_LRS"
    // OS_profile config
    os_type = "linux"
  }

  dsvm = {
    vm_name         = "datascience"
    vm_size         = "Standard_B2s"
    delete_os_disk  = "true"
    image_publisher = "MicrosoftWindowsDesktop"
    image_offer     = "windows-11"
    image_version   = "22631.3155.240210"
    image_sku       = "win11-23h2-pron"
    os_disk_name    = "DS_OsDisk"
    os_disk_caching = "ReadWrite"
    os_disk_create  = "FromImage"
    os_disk_type    = "Standard_LRS"
    // OS config
    os_type             = "windows"
    os_profile_password = "Datascience@2024"
  }
}
admin_username = "admin_jp"
ssh_key        = "~/.ssh/id_mlops.pub"
# Machine Learning Workspace
application_insight = {
  name = "mlops-ai"
  type = "web"
}
keyvault = {
  name     = "mlops-kv"
  sku_name = "standard"
}
storage_account = {
  name             = "mlopssa"
  tier             = "Standard"
  replication_type = "LRS"
}
inventory_path = "../ansible/config/inventory_tf.yml"
