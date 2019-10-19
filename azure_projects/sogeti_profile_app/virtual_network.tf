# Network head
resource "azurerm_virtual_network" "head" {
  name =  "${var.app_name}"
  address_space = ["10.0.0.0/16"]
  resource_group_name = "${azurerm_resource_group.location.name}"
  location = "${azurerm_resource_group.location.location}"
}

# Main subnet
resource "azurerm_subnet" "mainsubnet" {
  name = "mainsubnet"
  resource_group_name = "${azurerm_resource_group.resource_group.name}"
  virtual_network_name = "${azurerm_virtual_network.head.name}"
  address_prefix = "10.0.3.0/24"
}