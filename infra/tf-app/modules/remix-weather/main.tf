resource "azurerm_container_registry" "acr" {
  name                     = "cst8918finalprojectgroup4acr"
  location                 = var.region
  resource_group_name      = var.label_prefix
  sku                      = "Basic"
  admin_enabled            = true
}


resource "azurerm_redis_cache" "test" {
  name                = "redis-test-redis"
  location            = var.region
  resource_group_name = var.resource_group
  capacity            = 1
  family              = "C"
  sku_name            = "Basic"
  enable_non_ssl_port = true
}

resource "azurerm_redis_cache" "prod" {
  name                = "redis-prod-redis"
  location            = var.region
  resource_group_name = var.label_prefix
  capacity            = 1
  family              = "C"
  sku_name            = "Basic"
  enable_non_ssl_port = true
}