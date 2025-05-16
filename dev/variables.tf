variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
  default     = "project-dev-rg"
  
}
variable "location" {
  description = "The Azure location where the resource group will be created."
  type        = string
  default     = "westus"
}

variable "SUB_ID" {
  description = "The Azure subscription ID."
  type        = string
  default     = "bd6dd5cc-b9db-4d90-ab26-00bee5328f27"
  
}

variable "keyvault_name" {
  description = "The name of the Key Vault."
  type        = string
  default     = "project-dev-kv"
  
}

variable "cluster_name" {
  description = "The name of the AKS cluster."
  type        = string
  default     = "project-dev-aks"
  
}

variable "node_pool_name" {
  description = "The name of the AKS node pool."
  type        = string
  default     = "project-dev-nodepool"
  
}
