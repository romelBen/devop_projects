resource "azurerm_dns_zone" "test" {
  name                = "" # CHANGE Domain name
  resource_group_name = "${azurerm_resource_group.main.name}"
}

resource "azurerm_dns_a_record" "test" {
  name                = "Sogeti_Record"
  zone_name           = "${azurerm_dns_zone.test.name}"
  resource_group_name = "${azurerm_resource_group.main.name}"
  ttl                 = 300
  records             = [""] # CHANGE Record IP address
}