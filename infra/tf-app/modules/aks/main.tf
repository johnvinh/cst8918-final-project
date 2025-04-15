resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.aks_name
  location            = var.region
  resource_group_name = var.label_prefix
  dns_prefix          = "${var.label_prefix}-dns"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_B2s"
    auto_scaling_enabled = true
    max_count  = 3  
    min_count  = 1  
  }

  identity {
    type = "SystemAssigned"
  }

  kubernetes_version = "1.32.0"

}


output "kube_config" {
  value     = azurerm_kubernetes_cluster.aks.kube_config_raw
  sensitive = true
}

output "aks_id" {
  value = azurerm_kubernetes_cluster.aks.id
}

output "aks_name" {
  value = azurerm_kubernetes_cluster.aks.name
}