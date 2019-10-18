resource "azurerm_resource_group" "resource_group" {
  name = "Sogeti-Profile-App"
  location = "eastus"

  tags {
      Owner = "Romel Benavides"
  }
}