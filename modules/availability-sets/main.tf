resource "azurerm_availability_set" "availability-set" {
  name = "${var.availability_set_name}"
  location = "${var.location}"
  resource_group_name = "${var.resource_group_name}"
  managed = "true"
  platform_fault_domain_count = "2"
  tags {
    environment = "TerraTest"
  }
}