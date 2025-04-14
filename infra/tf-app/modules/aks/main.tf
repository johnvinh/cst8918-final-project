resource "azurerm_kubernetes_cluster" "aks" {
  name                = "${label_prefix}-FPaks"
  location            = var.region
  resource_group_name = var.label_prefix
  dns_prefix          = "${var.label_prefix}-dns"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_B2s"
    enable_auto_scaling  = true
    max_count  = 3  
    min_count  = 1  
  }

  identity {
    type = "SystemAssigned"
  }

}


output "kube_config" {
  value     = azurerm_kubernetes_cluster.aks.kube_config_raw
  sensitive = true
}

output "aks_id" {
  value = azurerm_kubernetes_cluster.aks.id
}