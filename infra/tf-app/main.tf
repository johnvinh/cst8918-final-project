terraform {
  required_version = ">= 1.1.0"

  required_providers {
    # Azure Resource Manager provider and version
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }

  backend "azurerm" {
    storage_account_name = "cst8918storagegroupfp4"
    container_name       = "tfstate"
    key                  = "prod.app.tfstate"
    use_oidc             = true
  }

}

resource "azurerm_resource_group" "cst8918_rg" {
  name     = var.resource_group_name
  location = var.region
}

# Define providers and their config params
provider "azurerm" {
  # Leave the features block empty to accept all defaults
  subscription_id = var.subscription_id
  features {}
  use_oidc = true
}


module "network" {
  source              = "./modules/network"
  resource_group_name = azurerm_resource_group.cst8918_rg.name
  region              = azurerm_resource_group.cst8918_rg.location

  depends_on = [azurerm_resource_group.cst8918_rg]
}


module "aks_test" {
  source = "./modules/aks"

  aks_name           = "aks_test"
  environment        = "test"
  node_count         = 1
  vm_size            = "Standard_B2s"
  kubernetes_version = "1.32.0"
  location           = azurerm_resource_group.cst8918_rg.location
  resource_group     = azurerm_resource_group.cst8918_rg.name
  subnet_id          = module.network.subnet_ids["test"]
}

module "aks_prod" {
  source = "./modules/aks"

  aks_name           = "aks_prod"
  environment        = "prod"
  min_count          = 1
  max_count          = 3
  vm_size            = "Standard_B2s"
  kubernetes_version = "1.32.0"
  location           = azurerm_resource_group.cst8918_rg.location
  resource_group     = azurerm_resource_group.cst8918_rg.name
  subnet_id          = module.network.subnet_ids["prod"]
}

# module "remix_weather" {
#   source = "./modules/remix-weather"

#   region           = azurerm_resource_group.cst8918_rg.location
#   resource_group     = azurerm_resource_group.cst8918_rg.name
#   aks_test_name      = module.aks_test.aks_name
#   aks_prod_name      = module.aks_prod.aks_name
#   subnet_id         = module.network.subnet_ids["prod"]
# }