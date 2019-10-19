# Outputs
output "app_service_name" {
  value = "${azurerm_app_service.main.name}"
}

output "app_service_default_hostname" {
    value = "https://${azurerm_app_service.main.default_site_hostname}"
}

# CHANGE need to look into this
output "CDN_endpoint_ID" {
  value = "${azurerm_cdn_endpoint.main-endpoint}.azureedge.net"
}

output "sql_server_fqdn" {
  value = "${azurerm_sql_server.sql-server.fully_qualified_domain_name}"
}

output "database_name" {
  value = "${azurerm_sql_database.sql-database.name}"
}
