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
  source = "github.com/Jath1024/Azure-IaasWeb-Terraform//modules/operational-vnet"
}
module "mngmt_vnet" {
  source = "github.com/Jath1024/Azure-IaasWeb-Terraform//modules/mngmt-subnet"
}

#Build the desired subnets with NSGs applied
module "web_subnet" {
  source = "github.com/Jath1024/Azure-IaasWeb-Terraform//modules/web-subnet"
}
module "biz_subnet" {
  source = "github.com/Jath1024/Azure-IaasWeb-Terraform//modules/biz-subnet"
}
module "data_subnet" {
  source = "github.com/Jath1024/Azure-IaasWeb-Terraform//modules/data-subnet"
}
module "adds_subnet" {
  source = "github.com/Jath1024/Azure-IaasWeb-Terraform//modules/adds-subnet"
}
module "mngmt_subnet" {
  source = "github.com/Jath1024/Azure-IaasWeb-Terraform//modules/mngmt-subnet"
}

# Deploy VMs, LB and availabiliity sets into each subnet
module availability_set {
  source = "github.com/Jath1024/Azure-IaasWeb-Terraform//modules/availability-sets"
  name = "web_as"
}

module web_vm {
  source = "github.com/Jath1024/Azure-IaasWeb-Terraform//modules/web-servers"
  name = "web"
}
