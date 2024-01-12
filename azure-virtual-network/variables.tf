variable "resource_group_name" {
  description = "The name of the Azure resource group."
}

variable "vnet_name" {
  description = "The name of the Virtual Network."
}

variable "address_space" {
  description = "The address space for the Virtual Network."
  type        = list(string)
}

variable "location" {
  description = "The Location for Virtual Network."
  type        = string
}