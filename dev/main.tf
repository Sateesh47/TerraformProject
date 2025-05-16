resource "azurerm_resource_group" "rg" {
  name = var.resource_group_name
  location = var.location
}

module "serviceprincipal" {
  source = "../modules/serviceprincipal"
  service_principal_name = var.service_principal_name
  depends_on = [ azurerm_resource_group.rg ]
}

resource "azurerm_role_assignment" "rolespn" {
  scope = "/subscriptions/${var.SUB_ID}"
  role_definition_name = "Contributor"
  principal_id = module.serviceprincipal.service_principal_object_id
  depends_on = [ module.serviceprincipal ]
}
module "keyvalut" {
  source = "../modules/keyvault"
  keyvault_name = var.keyvault_name
  resource_group_name = var.resource_group_name
  location = var.location
  //service_principal_name = var.service_principal_name
  depends_on = [ azurerm_role_assignment.rolespn ]
  tags = {
    environment = "dev"
  }
}
# resource "azurerm_key_vault_access_policy" "terraform" {
#   key_vault_id = module.keyvalut.key_vault_id

#   tenant_id = module.serviceprincipal.service_principal_tenant_id
#   object_id = module.serviceprincipal.service_principal_object_id
#   secret_permissions = [
#     "Get",
#     "Set",
#     "List"
#   ]
# }

resource "azurerm_key_vault_secret" "aks_secret" {
  name = module.serviceprincipal.service_principal_client_id
  value = module.serviceprincipal.azuread_service_principal_password
  key_vault_id = module.keyvalut.key_vault_id
  depends_on = [ module.keyvalut ]
}

module "aks" {
  source = "../modules/aks"
  resource_group_name = var.resource_group_name
  location = var.location
 // service_principal_name = var.service_principal_name
  client_id = module.serviceprincipal.service_principal_client_id
  client_secret = module.serviceprincipal.azuread_service_principal_password
  cluster_name = var.cluster_name
  node_pool_name = var.node_pool_name
  depends_on = [ module.serviceprincipal ]
}

resource "local_file" "kubeconfig" {
  filename = "${path.module}/kubeconfig"
  content  = module.aks.config
  depends_on = [ module.aks ]
  
}