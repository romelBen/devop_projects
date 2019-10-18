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

# Network Interface
resource "azurerm_network_interface" "net-int" {
    name = "networkinterface-${count.index + 1}"
    location = "${azurerm_resource_group.resource_group.location}"
    resource_group_name = "${azurerm_resource_group.resource_group.name}"
    count = "1"

    ip_configuration {
        name = "ipconfig-${count.index + 1}"
        subnet_id = "${azurerm_subnet.mainsubnet.id}"
        private_ip_address_allocation = "dynamic"
    }
}
