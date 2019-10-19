resource "azurerm_sql_server" "sql-server" {
  name = "{var.app_name}"
  resource_group_name = "${azurerm_resource_group.resource_group.name}"
  location = "${azurerm_resource_group.resource_group.location}"
  version = "12.0"
  administrator_login = "4dmfg345R70"
  administrator_login_password = "4-v3by-pr3!!y-L0g!c"
}

resource "azurerm_sql_database" "sql-database" {
  name = "${var.prefix}-db"
  resource_group_name = "${azurerm_resource_group.resource_group.name}"
  location = "${azurerm_resource_group.main.location}"
  server_name = "${azurerm_sql_server.sql-server.name}"
  edition = "Basic"
  collation = "SQL_Latin1_General_CP1_CI_AS"
  create_mode ="Default"
  requested_service_objective_name = "Basic"
}

resource "azurerm_sql_virtual_network_rule" "sqlvnetrule" {
    name = "sql-vnet-rule"
    resource_group_name = "${azurerm_resource_group.resource_group.name}"
    server_name = "${azurerm_sql_server.sql-server.name}"
    subnet_id = "${azurerm_subnet.db-sub.id}"
}

resource "azurerm_subnet" "db-sub" {
  name = "DB Subnet"
  resource_group_name = "${azurerm_resource_group.resource_group.name}"
  virtual_network_name = "${azurerm_virtual_network.head.name}"
  address_prefix = "10.0.2.0/24"
  service_endpoints = ["Microsoft.Sql"]
}

# Enables the "Allow Access to Azure services" box as described in the API docs
# https://docs.microsoft.com/en-us/rest/api/sql/firewallrules/createorupdate
resource "azurerm_sql_firewall_rule" "main-firewall" {
  name = "allow-azure-services"
  resource_group_name = "${azurerm_resource_group.resource_group.name}"
  server_name = "${azurerm_sql_server.sql-server.name}"
  start_ip_address = "0.0.0.0" # CHANGE
  end_ip_address = "0.0.0.0" # CHANGE
}
