resource "azurerm_storage_account" "stor" {
  name = "${var.prefix}-stor"
  location = "${azurerm_resource_group.main.location}"
  resource_group_name = "${azurerm_resource_group.main.name}"
  account_tier = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_cdn_profile" "main-profile" {
  name = "${var.prefix}-cdn"
  location = "${azurerm_resource_group.main.location}"
  resource_group_name = "${azurerm_resource_group.main.name}"
  sku = "Standard_Akamai"
}

resource "azurerm_cdn_endpoint" "main-endpoint" {
  name = "${var.prefix}-cdn"
  profile_name = "${azurerm_cdn_profile.main-profile.name}"
  location = "${azurerm_resource_group.main.location}"
  resource_group_name = "${azurerm_resource_group.main.name}"

  origin {
      name = "${var.prefix}-cdn"
      host_name = "" # ADD HTML CHANGE
      http_port = 80
      https_port = 443
  }
}


