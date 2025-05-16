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
  default     = "~/.ssh/id_rsa.pub"
  
}