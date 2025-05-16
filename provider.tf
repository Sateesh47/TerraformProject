terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.25.0"
    }
     azuread = {
      source = "hashicorp/azuread"
      version = "3.0.1"
    }
  }
}


provider "azurerm" {
  # Configuration options
  features {
    
  }
  // subscription_id = "bd6dd5cc-b9db-4d90-ab26-00bee5328f27"
}
provider "azuread" {
  # Configuration options
}


