resource "azurerm_subnet" "mngmt_subnet" {
  name = "iwa-mngmt-subnet"
  resource_group_name = "${var.resource_group_name}"
  network_security_group_id = "${azurerm_network_security_group.iaaswebapp_biz_nsg.id}"
  address_prefix = "10.1.0.0/27"
  virtual_network_name = "iwa-mngmt-vnet"
}
resource "azurerm_network_security_group" "iaaswebapp_mngmt_nsg" {
  name = "iwa-mngmt-nsg"
  location = "${var.location}"
  resource_group_name = "${var.resource_group_name}"
  
  tags {
    environment = "TerraTest"
  }
}
