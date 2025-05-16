variable "keyvault_name" {
  description = "Name of the Key Vault"
  type        = string
  
}

variable "location" {
  description = "Location for the Key Vault"
  type        = string
 // default     = "East US"
  
}

variable "tags" {
  description = "Tags to be applied to the Key Vault"
  type        = map(string)
  
}