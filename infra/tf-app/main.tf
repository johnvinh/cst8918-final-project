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

resource "azurerm_resource_group" "cst8918_rg" {
  name     = "cst8918-final-project-group-4"
  location = var.region
}

module "network" {
  source              = "./modules/network"
  resource_group_name = var.resource_group_name
  location            = var.region

  depends_on = [azurerm_resource_group.cst8918_rg]
}


module "aks_test" {
  source              = "./modules/aks"
  resource_group_name = var.label_prefix
  location            = var.region
  cluster_name        = "aks-test"
  node_count          = 1
  min_count           = 1
  max_count           = 1
  enable_auto_scaling = true
}

module "aks_prod" {
  source              = "./modules/aks"
  resource_group_name = var.label_prefix
  location            = var.region
  cluster_name        = "aks-prod"
  node_count          = 1
  min_count           = 1
  max_count           = 3
  enable_auto_scaling = true
}