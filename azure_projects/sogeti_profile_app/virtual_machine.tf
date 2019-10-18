resource "azurerm_virtual_machine" "app_vm" {
  name = "${var.app_name}-vmexample-${count.index + 1}"
  location = "${azurerm_resource_group.resource_group.location}"
  resource_group_name = "${azurerm_resource_group.resource_group.name}"
  network_interface_ids = ["$element(azurerm_network_interface.net-int.*.id)"]
  vm_size = "Standard_DS1_v2"
  count = "1"
  delete_os_disk_on_termination = true


  delete_data_disks_on_termination = true

  storage_image_reference {
      publisher = "Canonical"
      offer = "UbuntuServer"
      sku = "16.04-LTS"
      version = "latest"
  }

  storage_os_disk {
      name = "${var.app_name}-osdisk1-${count.index + 1}"
      caching = "ReadWrite"
      create_option = "FromImage"
      managed_disk_type = "Standard_LRS"
  }
  
  os_profile {
      computer_name = "${var.app_name}-${count.index + 1}"
      admin_username = "testadmin"
      admin_password = "thisatest"
  }

  os_profile_linux_config {
      disable_password_authentication = false
  }

  tags {
      environment = "Test"
  }
}
