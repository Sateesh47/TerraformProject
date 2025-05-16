variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "aks-dev-rg"
  
}

variable "location" {
  description = "The Azure region to deploy the AKS cluster."
  type        = string
  default     = "westus"
  
}

variable "service_principal_name" {
  description = "Name of the service principal"
  type        = string
  default     = "aks-dev-sp"
  
}

variable "SUB_ID" {
  default = {
    "subscription_id" = "bd6dd5cc-b9db-4d90-ab26-00bee5328f27"
  }
}

variable "keyvault_name" {
  description = "Name of the Key Vault"
  type        = string
  default     = "aksdevkeyvault"
  
}

variable "node_pool_name" {
  description = "Name of the AKS node pool"
  type        = string
  default     = "aksnodepool"
  
}

variable "cluster_name" {
  description = "Name of the AKS cluster"
  type        = string
  default     = "aks-devcluster"
  
}