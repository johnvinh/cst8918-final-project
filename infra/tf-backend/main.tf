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
  name     = "${var.label_prefix}-4"
  location = var.region
}

resource "azurerm_storage_account" "cst8918_storage" {
  name                     = "${var.label_prefix}-4"
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


# virtual network with IP address space 10.0.0.0/14
resource "azurerm_virtual_network" "vnet" {
  name                = "${var.label_prefix}-FPVnet"
  address_space       = ["10.0.0.0/14"]
  location            = azurerm_resource_group.cst8918_rg.location
  resource_group_name = azurerm_resource_group.cst8918_rg.name
}

#  - 4 subnets, where the second octet of the IP address space is used to represent the environment
#     - `prod` with IP address space 10.0.0.0/16
resource "azurerm_subnet" "prod" {
  name                 = "${var.label_prefix}-FPSubnet-prod"
  resource_group_name  = azurerm_resource_group.cst8918_rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.0.0/16"]
}

#     - `test` with IP address space 10.1.0.0/16
resource "azurerm_subnet" "test" {
  name                 = "${var.label_prefix}-FPSubnet-test"
  resource_group_name  = azurerm_resource_group.cst8918_rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.1.0.0/16"]
}

#     - `dev` with IP address space 10.2.0.0/16
resource "azurerm_subnet" "dev" {
  name                 = "${var.label_prefix}-FPSubnet-dev"
  resource_group_name  = azurerm_resource_group.cst8918_rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.2.0.0/16"]
}

#     - `admin` with IP address space 10.3.0.0/16

resource "azurerm_subnet" "admin" {
  name                 = "${var.label_prefix}-FPSubnet-admin"
  resource_group_name  = azurerm_resource_group.cst8918_rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.3.0.0/16"]
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