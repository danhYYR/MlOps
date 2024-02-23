resource "azurerm_virtual_network" "demovnet_workspace" {
  name = "app-vnet"
  resource_group_name = var.rg_name
  location = var.rg_location
  address_space = var.vnet_wokspace_address
}
resource "azurerm_virtual_network" "demovnet_storage" {
  name = "db-vnet"
  resource_group_name = var.rg_name
  location = var.rg_location
  address_space = var.vnet_wokspace_address
}
## AKS Subnet
### Control Plane
resource "azurerm_subnet" "aks-cp" {
    resource_group_name = var.rg_name
    virtual_network_name = azurerm_virtual_network.demovnet_workspace.name
    name = "Apiserver"
    address_prefixes = var.aks_cp_address
    delegation {
      name = "AKS api-server"
      service_delegation {
        name = "Microsoft.ContainerService/managedClusters"
        actions = ["Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action"]
      }
    }
}
### Node subnet
resource "azurerm_subnet" "aks-node" {
    resource_group_name = var.rg_name
    virtual_network_name = azurerm_virtual_network.demovnet_workspace.name
    name = "Node-Vnet"
    address_prefixes = var.aks_node_address
}
### JumHost Subnet
resource "azurerm_subnet" "jp_vm" {
    resource_group_name = var.rg_name
    virtual_network_name = azurerm_virtual_network.demovnet_workspace.name
    name = "JP_VM-Vnet"
    address_prefixes = var.jp_vm_address
}
### Machine Learning subnet
resource "azurerm_subnet" "mlc" {
    resource_group_name = var.rg_name
    virtual_network_name = azurerm_virtual_network.demovnet_workspace.name
    name = "MLWorkspace-Subnet"
    address_prefixes = var.mlc_address
}
resource "azurerm_subnet" "mli" {
    resource_group_name = var.rg_name
    virtual_network_name = azurerm_virtual_network.demovnet_workspace.name
    name = "MLInstance-Subnet"
    address_prefixes = var.mli_address
}
## Public IP
resource "azurerm_public_ip" "demovnet_pulicIP" {
    name = "${var.rg_name}-IP"
    resource_group_name = var.rg_name
    location = var.rg_location
    allocation_method = "Static"
}
## DNS private zone
resource "azurerm_private_dns_zone" "dnsazureml" {
  name                = "privatelink.api.azureml.ms"
  resource_group_name = var.rg_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "vnetlinkml" {
  name                  = "dnsazuremllink"
  resource_group_name   = var.rg_name
  private_dns_zone_name = azurerm_private_dns_zone.dnsazureml.name
  virtual_network_id    = azurerm_virtual_network.demovnet_workspace.id
}

resource "azurerm_private_dns_zone" "dnsnotebooks" {
  name                = "privatelink.notebooks.azure.net"
  resource_group_name = var.rg_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "vnetlinknbs" {
  name                  = "dnsnotebookslink"
  resource_group_name   = var.rg_name
  private_dns_zone_name = azurerm_private_dns_zone.dnsnotebooks.name
  virtual_network_id    = azurerm_virtual_network.demovnet_workspace.id
}

## Network Security Group
locals {
  ports = [22, 80, 443,5432]
}
module "nsg" {
  source = "./nsg"
  rg_name = var.rg_name
  rg_location = var.rg_location
  nsg-ports = local.ports
}
resource "azurerm_subnet_network_security_group_association" "inbound-grp" {
  network_security_group_id = module.nsg.nsg-id
  subnet_id = azurerm_subnet.jp_vm.id
}