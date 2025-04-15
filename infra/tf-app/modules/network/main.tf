# virtual network with IP address space 10.0.0.0/14
resource "azurerm_virtual_network" "vnet" {
  name                = "${var.label_prefix}-FPVnet"
  address_space       = ["10.0.0.0/14"]
  location            = var.region
  resource_group_name = var.label_prefix
}

#  - 4 subnets, where the second octet of the IP address space is used to represent the environment
#     - `prod` with IP address space 10.0.0.0/16
resource "azurerm_subnet" "prod" {
  name                 = "${var.label_prefix}-FPSubnet-prod"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.0.0/16"]
}

#     - `test` with IP address space 10.1.0.0/16
resource "azurerm_subnet" "test" {
  name                 = "${var.label_prefix}-FPSubnet-test"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.1.0.0/16"]
}

#     - `dev` with IP address space 10.2.0.0/16
resource "azurerm_subnet" "dev" {
  name                 = "${var.label_prefix}-FPSubnet-dev"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.2.0.0/16"]
}

#     - `admin` with IP address space 10.3.0.0/16

resource "azurerm_subnet" "admin" {
  name                 = "${var.label_prefix}-FPSubnet-admin"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.3.0.0/16"]
}


output "subnet_ids" {
  value = {
    prod  = azurerm_subnet.prod.id
    test  = azurerm_subnet.test.id
    dev   = azurerm_subnet.dev.id
    admin = azurerm_subnet.admin.id
  }
}