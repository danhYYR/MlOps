data "azuread_service_principal" "pipeline-sp" {
  client_id  = var.sp_id
}

# resource "azuread_application" "main" {
#     display_name = var.sp-name
#     owners = [data.azurerm_client_config.current.object_id]
# }
# resource "azuread_service_principal" "demo-sp" {
#     client_id = azuread_application.main.client_id
#     app_role_assignment_required = true
#     owners = [data.azurerm_client_config.current.object_id]
# }
# resource "azuread_service_principal_password" "demo-sp-pass" {
#   service_principal_id = data.azuread_service_principal.pipeline-sp.object_id
# }
# Assign role for Vnet
resource "azurerm_role_assignment" "aks-vnet" {
    scope = var.vnet_id
    principal_id = data.azuread_service_principal.pipeline-sp.object_id
    role_definition_name = "Network Contributor"
}

resource "azurerm_role_assignment" "sp-role" {
    scope = var.rg_id
    principal_id = data.azuread_service_principal.pipeline-sp.object_id
    role_definition_name = "Contributor"
}