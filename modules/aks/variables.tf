variable "location" {
  description = "The Azure region to deploy the AKS cluster."
  type        = string
 // default     = "eastus"
  
}

variable "cluster_name" {
  description = "The name of the AKS cluster."
  type        = string
 // default     = "aks-cluster"
  
}

variable "node_pool_name" {
  description = "The name of the AKS node pool."
  type        = string
 // default     = "nodepool1"
  
}

variable "ssh_public_key_path" {
  description = "The path to the SSH public key for the AKS cluster."
  type        = string
  default     = "~/.ssh/id_rsa_new.pub"
  
}

variable "resource_group_name" {
  description = "The name of the resource group where the AKS cluster will be created."
  type        = string
 // default     = "aks-rg"
  
}

variable "client_id" {
  description = "The client ID of the service principal."
  type        = string
 // default     = module.servivepricipal.service_principal_client_id
  
}
variable "client_secret" {
  description = "The client secret of the service principal."
  type        = string
 // default     = module.servivepricipal.azuread_service_principal_password
  
}