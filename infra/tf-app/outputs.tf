output "resource_group_name" {
  value = azurerm_resource_group.cst8918_rg.name
}

output "aks_test_kube_config" {
  value     = module.aks_test.kube_config
  sensitive = true
}

output "aks_prod_kube_config" {
  value     = module.aks_prod.kube_config
  sensitive = true
}

output "network_subnet_ids" {
  value = module.network.subnet_ids
}
