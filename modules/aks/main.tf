data "azurerm_kubernetes_service_versions" "current" {
  location = var.location
  include_preview = false
}

resource "azurerm_kubernetes_cluster" "aks_cluster" {
  name = var.cluster_name
  location = var.location
    resource_group_name = var.resource_group_name
    dns_prefix = "${var.cluster_name}-dns"
    kubernetes_version =data.azurerm_kubernetes_service_versions.current.latest_version
    node_resource_group = "${var.cluster_name}-node-rg"
    default_node_pool {
      name = var.node_pool_name
      vm_size = "standard_ds2_v2"
      //zones = [1, 2, 3]
      auto_scaling_enabled =  true
      min_count = 1
        max_count = 3
        os_disk_size_gb = 30
        type = "VirtualMachineScaleSets"
    
      
    }

    service_principal {
        client_id = var.client_id
        client_secret = var.client_secret
    }

    linux_profile {
        admin_username = "azureuser"
        ssh_key {
            key_data =trimspace(file(var.ssh_public_key_path)) 
        }

        
    }

    network_profile {
           network_plugin = "azure"
           load_balancer_sku = "standard"
        }
  }