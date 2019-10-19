resource "azurerm_storage_account" "main-storage" {
  name = "${var.prefix}-main-storage"
  resource_group_name = "${azurerm_resource_group.main.name}"
  location = "${azurerm_resource_group.main.location}"
  account_tier = "Standard"
  account_replcation_type = "LRS"
}

resource "azurerm_storage_container" "main-container" {
  name = "Sogeti_App_Data"
  resource_group_name = "${azurerm_resource_group.main.name}"
  storage_account_name = "${azurerm_storage_account.main-storage.name}"
  container_access_type = "private"
}

resource "azurerm_storage_blob" "main-blob" {
  name                   = "my-awesome-content.zip" # CHANGE
  resource_group_name    = "${azurerm_resource_group.main.name}"
  storage_account_name   = "${azurerm_storage_account.main-storage.name}"
  storage_container_name = "${azurerm_storage_container.main-container.name}"
  type                   = "blob"
  source                 = "some-local-file.zip"
}