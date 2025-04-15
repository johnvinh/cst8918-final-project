terraform {
  backend "azurerm" {
    resource_group_name  = "cst8918-final-project-group-4"
    storage_account_name = "cst8918storagefp4"
    container_name       = "tfstate"
    key                  = "prod.app.tfstate"
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}
