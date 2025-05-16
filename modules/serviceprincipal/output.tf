output "service_principal_name" {
  value = azuread_application.aad_app.display_name
  
}

output "service_principal_object_id" {
  value = azuread_service_principal.service_principal.object_id
}

output "service_principal_tenant_id" {
  value = data.azuread_service_principal.service_principal.tenant_id
  
}

output "service_principal_client_id" {
  value = azuread_service_principal.service_principal.client_id
  
}

output "azuread_service_principal_password" {
  value = azuread_service_principal_password.service_principal_password.value
}