# Terraform source
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 2.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = ">=2.0.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.4.1"
    }
    null = {
      source  = "hashicorp/null"
      version = "3.2.2"
    }
  }
  backend "azurerm" {
    // Backend Config
  }
  required_version = ">=1.0.0"
}
# Provider
provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}
provider "azuread" {}
# Random for generate the name resource
# Random String Resource
resource "random_string" "myrandom" {
  length  = 3
  upper   = false
  special = false
  numeric = false
}
# Resource
## Resource Group
resource "azurerm_resource_group" "demomlops" {
  name     = var.rg_name
  location = var.rg_location
  tags     = { "${var.enviroment}" : "${var.rg_name}" }
}

## Vnet
module "vnet" {
  source                = "./modules/vnet"
  rg_name               = azurerm_resource_group.demomlops.name
  rg_location           = azurerm_resource_group.demomlops.location
  vnet_wokspace_address = local.vnet_workspace_address
  aks_cp_address        = local.aks_cp_address
  aks_node_address      = local.aks_node_address
  jp_vm_address         = local.jp_vm_address
  mlc_address           = local.mlc_address
  mli_address           = local.mli_address
}
# Service Principal
module "serviceprincipal" {
  source  = "./modules/serviceprincipal"
  vnet_id = module.vnet.cp_subnet_id
  rg_id   = azurerm_resource_group.demomlops.id
  sp_name = "aks-sp"
  sp_id   = var.sp_id
}
## AKS
module "aks-cluster" {
  source        = "./modules/aks"
  rg_name       = azurerm_resource_group.demomlops.name
  rg_location   = azurerm_resource_group.demomlops.location
  aks_name      = var.aks_name
  subnet_cp     = module.vnet.cp_subnet_id
  subnet_node   = module.vnet.node_subnet_id
  client_id     = var.sp_id
  client_secret = var.sp_secret
}
## JumpHostVM
module "jumphost" {
  source         = "./modules/jumphost"
  rg_name        = azurerm_resource_group.demomlops.name
  rg_location    = azurerm_resource_group.demomlops.location
  admin_username = var.admin_username
  ssh_key        = var.ssh_key
  vnet_subnet_id = module.vnet.jp_subnet_id
  publicip_id    = module.vnet.publicip_id
  depends_on     = [azurerm_resource_group.demomlops, module.vnet]
}
module "mlworkspace" {
  source          = "./modules/mlworkspace"
  tenant_id       = var.tenant_id
  rg_name         = azurerm_resource_group.demomlops.name
  rg_location     = azurerm_resource_group.demomlops.location
  sp_resource_id  = module.serviceprincipal.sp_resource_id
  app_name        = local.mlw_ai_name
  app_type        = local.mlw_ai_type
  kv_name         = "${local.mlw_kv_name}-${random_string.myrandom.id}"
  kv_sku          = local.mlw_kv_sku
  sa_name         = "${local.mlw_sa_name}${random_string.myrandom.id}"
  sa_rt           = local.mlw_sa_rt
  sa_tier         = local.mlw_sa_tier
  mlw_name        = var.mlw_name
  subnet_mlw      = module.vnet.jp_subnet_id
  dns_aml_id      = module.vnet.dns_aml_id
  dns_notbook_id  = module.vnet.dns_notbook_id
  mlc_name        = var.mlc_name
  mlc_vm_priority = var.mlc_vm_priority
  mlc_vm_size     = var.mlc_vm_size
  subnet_mli      = module.vnet.mli_subnet_id
  ssh_key         = var.ssh_key
}
# Self-Host Config
module "selfhost" {
  source         = "./modules/self_host"
  rg_name        = var.rg_name
  rg_location    = var.rg_location
  aks_name       = var.aks_name
  dns_aml_id     = module.vnet.dns_aml_id
  dns_notbook_id = module.vnet.dns_notbook_id
  mlw_id         = module.mlworkspace.mlw_id
  subnet_sh      = module.vnet.jp_subnet_id
  jumphost_data  = module.jumphost.jumphost_data
  inventory_path = var.inventory_path
}