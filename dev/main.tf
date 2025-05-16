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

resource "azurerm_key_vault_secret" "aks_secret" {
  name = module.serviceprincipal.client_id
  value = module.serviceprincipal.client_secret
  key_vault_id = module.keyvalut.keyvault_id
  depends_on = [ module.keyvalut ]
}

module "aks" {
  source = "../modules/aks"
  resource_group_name = var.resource_group_name
  location = var.location
 // service_principal_name = var.service_principal_name
  client_id = module.serviceprincipal.client_id
  client_secret = module.serviceprincipal.client_secret
  cluster_name = vat.cluster_name
  node_pool_name = var.node_pool_name
  depends_on = [ module.serviceprincipal ]
}

resource "local_file" "kubeconfig" {
  filename = "${path.module}/kubeconfig"
  content  = module.aks.kubeconfig
  depends_on = [ module.aks ]
  
}