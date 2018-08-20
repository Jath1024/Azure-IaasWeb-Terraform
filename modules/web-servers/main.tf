
resource "azurerm_network_interface" "web-nic" {
  count = "${var.number_of_web_servers}"
  name = "${var.name}-${count.index}-operational-nic"
  resource_group_name = "${var.resource_group_name}"
  location = "${var.location}"
  ip_configuration {
    name = "${var.name}-${count.index}-nic-config"
    subnet_id = "${modules.web-subnet.subnet_id}"
    private_ip_address_allocation = "dynamic"
  }
  tags {
    environment = "TerraTest"
  }
}
resource "azurerm_virtual_machine" "web-vm" {
  count = "${var.number_of_web_servers}"
  name = "operational-${var.name}-${count.index}"
  location = "${var.location}"
  resource_group_name = "${var.resource_group_name}"
  network_interface_ids = ["${azurerm_network_interface.web-nic.id}"]
  vm_size = "Standard_DS1_V2"
  availability_set_id = "${modules.availability_set}"
  delete_os_disk_on_termination = false
  delete_data_disks_on_termination = false
  storage_image_reference {
    publisher = "${var.os["publisher"]}"
    offer = "${var.os["offer"]}"
    sku = "${var.os["sku"]}"
    version = "${var.os["version"]}"
  }
  storage_os_disk {
    name = "${var.namespace}-${var.name}-${count.index}-os-disk"
    caching = "ReadWrite"
    create_option = "FromImage"
    managed_disk_type = "${var.vm_disk_type}"
  }
  os_profile {
    computer_name = "${var.name}-${count.index}"
    admin_username = "${var.username}"
    admin_password = "${var.password}"
  }
  os_profile_windows_config {
    provision_vm_agent = "true"
  }
  tags {
    environment = "${var.environment_tag}"
  }
}
# resource "azurerm_network_interface" "op-web2-nic" {
#   name = "operational-web-vm2-nic"
#   resource_group_name = "${var.resource_group_name}"
#   location = "${var.location}"
#   ip_configuration {
#     name = "web2-nic-config"
#     subnet_id = "${azurerm_subnet.web_subnet.id}"
#     private_ip_address_allocation = "dynamic" 
#   }
#   tags {
#     environment = "TerraTest"
#   }
# }

# resource "azurerm_virtual_machine" "op-web-2" {
#   name = "operational-web-vm2"
#   location = "${var.location}"
#   resource_group_name = "${var.resource_group_name}"
#   network_interface_ids = ["${azurerm_network_interface.op-web2-nic.id}"]
#   vm_size = "Standard_DS1_V2"
#   availability_set_id = "${azurerm_availability_set.op-web-as.id}"
#   delete_os_disk_on_termination = false
#   delete_data_disks_on_termination = false
#   storage_image_reference {
#     publisher = "MicrosoftWindowsServer"
#     offer = "WindowsServer"
#     sku = "2016-Datacenter"
#     version = "2016.127.20180613"
#   }
#   storage_os_disk {
#     name = "op-web-2-os-disk"
#     caching = "ReadWrite"
#     create_option = "FromImage"
#     managed_disk_type = "Premium_LRS"
#   }
#   os_profile {
#     computer_name = "web2"
#     admin_username = "thomja"
#     admin_password = "Password1234!"
#   }
#   os_profile_windows_config {
#     provision_vm_agent = "true"
#   }
#   tags {
#     environment = "TerraTest"
#   }
# }
