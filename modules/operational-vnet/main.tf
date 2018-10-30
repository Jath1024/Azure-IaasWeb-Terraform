
resource "azurerm_virtual_network" "operational_vnet" {
  name = "iwa-op-vnet"
  location = "${var.location}"
  resource_group_name = "${var.resource_group_name}"
  address_space = ["10.0.0.0/16"]
  
  tags {
    environment = "TerraTest"
  }
}