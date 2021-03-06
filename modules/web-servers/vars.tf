

# General Vars
variable "location" {
  description = "Location for deployment"
  default = "westeurope"
  }

variable "environment_tag" {
  default = "development"
}


# VM Vars
variable "number_of_web_servers" {
  description = "Number of Web Servers"
  default = "2"
}

variable "namespace" {
  description = "Namespace used in naming convention to identify the sub-section of the environment"
  default = ""
}
variable "name" {
  description = "Base identifier of the VM"
  default = "web"
  }

variable "username" {
  description = "Username for server"
  default = "thomja"
  }
variable "password" {
  description = "Password for server"
  default = "P34zcdx!123a"
  }

variable "resource_group_name" {
  description = "Resource Group name"
  default = "iaaswebapp"
  }

  variable "vm_disk_type" {
  description = "VM OS disk type"
  default = "Standard_LRS"
  }
variable "os" {
      description = "Disk image with preinstalled OS"
      type = "map"
      default = {
      publisher = "MicrosoftWindowsServer"
      offer = "WindowsServer"
      sku = "2016-Datacenter"
      version = "latest"
    }
  }