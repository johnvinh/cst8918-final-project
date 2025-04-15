terraform {
  required_version = ">= 1.1.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.94.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "a14d25e0-b8df-4651-933c-cb1ce9a3ba5a"
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.region
}

# Directly define the Redis resources without using modules
resource "azurerm_redis_cache" "weather_cache_test" {
  name                = "weather-cache-test"
  location            = var.region
  resource_group_name = var.resource_group_name

  capacity            = 1
  family              = "C"
  sku_name            = "Standard"
  enable_non_ssl_port = false
  minimum_tls_version = "1.2"

  redis_configuration {
    maxmemory_policy = "allkeys-lru"
  }

  tags = {
    environment = "test"
    project     = "cst8918"
  }
}

resource "azurerm_redis_cache" "weather_cache_prod" {
  name                = "weather-cache-prod"
  location            = var.region
  resource_group_name = var.resource_group_name

  capacity            = 1
  family              = "C"
  sku_name            = "Standard"
  enable_non_ssl_port = false
  minimum_tls_version = "1.2"

  redis_configuration {
    maxmemory_policy = "allkeys-lru"
  }

  tags = {
    environment = "prod"
    project     = "cst8918"
  }
}