resource "azurerm_resource_group" "main" {
  name = "Sogeti-Profile-App"
  location = "eastus"

  tags {
      Owner = "Romel Benavides"
  }
}