

resource "azurerm_subnet" "web_subnet" {
  name = "iwa-web-subnet"
  resource_group_name = "${var.resource_group_name}"
  network_security_group_id = "${azurerm_network_security_group.iaaswebapp_web_nsg.id}"
  address_prefix = "10.0.1.0/24"
  virtual_network_name = "iwa-op-vnet"
}

resource "azurerm_network_security_group" "iaaswebapp_web_nsg" {
  name = "iwa-web-nsg"
  location = "${var.location}"
  resource_group_name = "${var.resource_group_name}"
  
  tags {
    environment = "TerraTest"
  }
}

resource "azurerm_network_security_rule" "https_in_web_nsg_rule" {
  name                        = "port-443-in"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = "${var.resource_group_name}"
  network_security_group_name = "${azurerm_network_security_group.iaaswebapp_web_nsg.name}"
}

resource "azurerm_network_security_rule" "rdp_in_web_nsg_rule" {
  name                        = "port-3389-in"
  priority                    = 200
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "3389"
  source_address_prefix       = "10.1.0.0/27"
  destination_address_prefix  = "*"
  resource_group_name         = "${var.resource_group_name}"
  network_security_group_name = "${azurerm_network_security_group.iaaswebapp_web_nsg.name}"
}