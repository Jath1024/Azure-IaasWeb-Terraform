variable "resource_group_name" {
  description = "The resource group name for the entire deployment"
  default = "iaaswebapp"
}

variable "location" {
  description = "The location for the deployment"
  default = "uksouth"
}

variable "number_of_web_servers" {
  description = "The number of web servers to create in the web subnet"
  default = "2"
}


variable "client_id" {}
variable "client_secret" {}

