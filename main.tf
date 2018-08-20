provider "azurerm" {
    version = "=1.5.0"
}

terraform {
    backend "azurerm" {}
}

# Build base resource group to contain all resources

resource "azurerm_resource_group" "iaaswebapp" {
  name = "${var.resource_group_name}"
  location = "${var.location}"
  
  tags {
    environment = "TerraTest"
  }
}


#Build the VNETs
module "operational_vnet" {
  source = "./modules/operational-vnet"
}
module "mngmt_vnet" {
  source = "./modules/mngmt-vnet"
}

#Build the desired subnets with NSGs applied
module "web_subnet" {
  source = "./modules/web-subnet"
}
module "biz_subnet" {
  source = "./modules/biz-subnet"
}
module "data_subnet" {
  source = "./modules/data-subnet"
}
module "adds_subnet" {
  source = "./modules/adds-subnet"
}
module "mngmt_subnet" {
  source = "./modules/mngmt-subnet"
}

# Deploy VMs, LB and availabiliity sets into each subnet
module availability_set {
  source = "./modules/availability-sets"
}

module web_vm {
  source = "./modules/web-servers"
  name = "web"
}
