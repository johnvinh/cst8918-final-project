resource "azurerm_container_registry" "acr" {
  name                     = "weatherappacr"
  location                 = var.region
  resource_group_name      = var.label_prefix
  sku                      = "Basic"
}