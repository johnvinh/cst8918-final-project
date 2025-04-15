terraform {
  required_version = ">= 1.1.0"

  required_providers {
    # Azure Resource Manager provider and version
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.94.0"
    }
  }

}

# Define providers and their config params
provider "azurerm" {
  # Leave the features block empty to accept all defaults
  features {}
}


module "network" {
  source              = "./modules/network"
  resource_group_name = var.resource_group_name
  location            = var.region

  depends_on = [azurerm_resource_group.cst8918_rg]
}


module "aks_test" {
  source = "./modules/aks"

  environment        = "test"
  node_count         = 1
  vm_size            = "Standard_B2s"
  kubernetes_version = "1.32.0"
  location           = var.location
  resource_group     = module.network.resource_group_name
  subnet_id          = module.network.subnet_ids["test"]
}

module "aks_prod" {
  source = "./modules/aks"

  environment        = "prod"
  min_count          = 1
  max_count          = 3
  vm_size            = "Standard_B2s"
  kubernetes_version = "1.32.0"
  location           = var.location
  resource_group     = module.network.resource_group_name
  subnet_id          = module.network.subnet_ids["prod"]
}

module "remix_weather" {
  source = "./modules/remix-weather"

  location           = var.location
  resource_group     = module.network.resource_group_name
  aks_test_name      = module.aks_test.aks_name
  aks_prod_name      = module.aks_prod.aks_name
  subnet_ids         = module.network.subnet_ids
}