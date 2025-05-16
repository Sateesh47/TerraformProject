output "config" {
    value = azurerm_kubernetes_cluster.aks_cluster.kube_admin_config_raw
    description = "The raw kubeconfig file for the AKS cluster"
  
}