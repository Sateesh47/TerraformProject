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
  
}
provider "azuread" {
  # Configuration options
}


