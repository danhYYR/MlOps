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
# Jumhost define
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