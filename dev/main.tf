resource "azurerm_resource_group" "rg" {
  name = var.resource_group_name
  location = var.location
}

module "servivepricipal"{
    source = "../modules/serviceprincipal"
   // service_principal_name = "Project Service Principal"
   // resource_group_name = azurerm_resource_group.rg.name 
    depends_on = [ azurerm_resource_group.rg ]
}

resource "azurerm_role_assignment" "rolesp" {
    scope          = "/subscriptions/${var.SUB_ID}"
  principal_id   = module.servivepricipal.service_principal.object_id
  principal_type = "ServicePrincipal"
  role_definition_name = "Contributor"
 // scope          = azurerm_resource_group.rg.id

  depends_on = [ module.servivepricipal ]
  
}

module "keyvault" {
  source = "../modules/keyvault"
  keyvault_name = var.keyvault_name
  location = var.location
 // resource_group_name = azurerm_resource_group.rg.name
 tags = {
    environment = "dev"
  }
  depends_on = [ azurerm_role_assignment.rolesp ]
  
}

resource "azurerm_key_vault_secret" "kvs" {
  name = module.servivepricipal.client_id
  value = module.servivepricipal.client_secret
  key_vault_id = module.keyvault.keyvault_id
  depends_on = [ module.keyvault ]
}

module "aks"{
    source = "../modules/aks"
    cluster_name = var.cluster_name
   // resource_group_name = azurerm_resource_group.rg.name
    location = var.location
    node_pool_name = var.node_pool_name

    depends_on = [ module.servivepricipal ]
}

resource "local_file" "kubeconfig" {
  depends_on   = [module.aks]
  filename     = "./kubeconfig"
  content      = module.aks.config
  
}