resource "azurerm_redis_cache" "weather_cache" {
  name                = var.redis_name
  location            = var.region
  resource_group_name = var.resource_group_name

  capacity            = 1                # 250MB cache size
  family              = "C"              # C = Standard/Basic
  sku_name            = "Standard"       # Standard is good for test/prod
  enable_non_ssl_port = false            # More secure
  minimum_tls_version = "1.2"

  redis_configuration {
    maxmemory_policy = "allkeys-lru"
  }

  tags = {
    environment = var.environment
    project     = "cst8918"
  }
}
