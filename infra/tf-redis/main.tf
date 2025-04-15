
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
}
module "redis_test" {
  source              = "./modules/remix-app"
  redis_name          = "weather-cache-test"
  location            = var.region
  resource_group_name = "cst8918-final-project-group-1" # change to your actual group name
  environment         = "test"
}

module "redis_prod" {
  source              = "./modules/remix-app"
  redis_name          = "weather-cache-prod"
  location            = var.region
  resource_group_name = "cst8918-final-project-group-1"
  environment         = "prod"
}
