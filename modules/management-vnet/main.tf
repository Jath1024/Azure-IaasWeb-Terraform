
resource "azurerm_virtual_network" "mngmt_vnet" {
  name = "iwa-mnmgt-vnet"
  location = "${var.location}"
  resource_group_name = "${var.resource_group_name}"
  address_space = ["10.1.0.0/124"]
  
  tags {
    environment = "TerraTest"
  }
}