resource "azurerm_sql_server "sqlserver {
  name = "{var.app_name}"
  resource_group_name = "${azurerm_resource_group.resource_group.name}"
  location = "${azurerm_resource_group.resource_group.location}"
  version = "12.0"
  administrator_login = "4dmfg345R70"
  administrator_login_password = "4-v3by-pr3!!y-L0g!c"
}

resource "azurerm_sql_virtual_network_rule" "sqlvnetrule" {
    name = "sql-vnet-rule"
    resource_group_name = "${azurerm_resource_group.resource_group.name}"
    server_name = "${azurerm_sql_server .sqlserver.name}"
    subnet_id = "${azurerm_subnet.db-sub.id}"
}

