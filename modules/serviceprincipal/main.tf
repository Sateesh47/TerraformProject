data "azuread_client_config" "current" {
   # Configuration options
}
 
resource "azuread_application" "aad_app" {
  display_name = var.service_principal_name
  owners = [data.azuread_client_config.current.object_id]
  
}

resource "azuread_service_principal" "service_principal" {
  client_id = azuread_application.aad_app.client_id
  app_role_assignment_required = true
  owners = [data.azuread_client_config.current.object_id]
}

resource "azuread_service_principal_password" "service_principal_password" {
  service_principal_id = azuread_service_principal.service_principal.id
}

