# Configure the Terraform runtime requirements.
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
  name     = "${var.label_prefix}-githubactions-rg"
  location = var.region
}

resource "azurerm_storage_account" "cst8918_storage" {
  name                     = "${var.label_prefix}githubactionss"
  resource_group_name      = azurerm_resource_group.cst8918_rg.name
  location                 = azurerm_resource_group.cst8918_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "staging"
  }
}

resource "azurerm_storage_container" "tfstate" {
  name                  = "tfstate"
  storage_account_name  = azurerm_storage_account.cst8918_storage.name
  container_access_type = "private"
}

output "resource_group_name" {
  value = azurerm_resource_group.cst8918_rg.name
}

output "storage_account_name" {
  value = azurerm_storage_account.cst8918_storage.name
}

output "container_name" {
  value = azurerm_storage_container.tfstate.name
}

output "primary_access_key" {
  value     = azurerm_storage_account.cst8918_storage.primary_access_key
  sensitive = true
}