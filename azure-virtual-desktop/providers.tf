terraform {
  required_version = ">= 1.4.6, < 1.6.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.50.0, < 3.70.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.5.1"
    }
    template = {
      source  = "hashicorp/template"
      version = "2.2.0"
    }
  }
}