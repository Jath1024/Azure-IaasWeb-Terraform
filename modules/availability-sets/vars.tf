# Availability Set Vars
variable "availability_set_name" {
  description = "name of availability set"
  default = "iaw-as"
}
variable "location" {
  description = "Location for deployment"
  default = "westeurope"
  }

variable "resource_group_name" {
  description = "Resource Group name"
  default = "iaaswebapp"
  }

