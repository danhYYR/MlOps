# Vnet
locals {
  vnet_workspace_address = lookup(var.Vnet_Workspace,"address_prefixes","10.0.0.0/8")
  subnet_workspace_address = lookup(var.Vnet_Workspace,"subnet",
  {
        aks_control = ["10.0.1.0/28"]
        aks_node = ["10.0.1.0/28"]
        jumphost_vm = "10.0.5.0/28"
        mli = "10.0.10.0/24"
        mlc = "10.0.50.0/24"
    })
}
locals {
  aks_cp_address = lookup(local.subnet_workspace_address,"aks_control",["10.0.1.0/24"])
  aks_node_address = lookup(local.subnet_workspace_address,"aks_node",["10.0.2.0/24"])
  jp_vm_address = lookup(local.subnet_workspace_address,"jumphost_vm",["10.0.5.0/24"])
  mlc_address = lookup(local.subnet_workspace_address,"mlc",["10.0.10.0/24"])
  mli_address = lookup(local.subnet_workspace_address,"mli","10.0.50.0/24")
}
locals {
  mlw_sa_name = lookup(
    var.storage_account,
  "name","mlsa")
  mlw_sa_tier = lookup(
    var.storage_account,
  "tier","Standard")
  mlw_sa_rt = lookup(
    var.storage_account,
  "replication_type","LRS")

  mlw_kv_name = lookup(
    var.keyvault,
  "name","mlops-kv")
  mlw_kv_sku = lookup(
    var.storage_account,
  "sku_name","standard")
  mlw_ai_name = lookup(
    var.application_insight,
  "name","mlops-ai")
  mlw_ai_type = lookup(
    var.storage_account,
  "type","web")
}