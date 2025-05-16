data "azuread_client_config" "current" {
  
}

resource "azurerm_key_vault" "akv" {
    name                = var.keyvault_name
    location            = var.location
    resource_group_name = var.resource_group_name
    sku_name            = "standard"
    tenant_id           = data.azuread_client_config.current.tenant_id
    enabled_for_disk_encryption = true
    purge_protection_enabled = false
    soft_delete_retention_days = 7
    enable_rbac_authorization = true
    
   tags = var.tags
}