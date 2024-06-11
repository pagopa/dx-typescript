terraform {

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.96.0"
    }

  }

  backend "azurerm" {
    resource_group_name  = "terraform-state-rg"
    storage_account_name = "tfdevdx"
    container_name       = "terraform-state"
    key                  = "dx-typescript.resources.dev.italynorth.tfstate"
  }
}

provider "azurerm" {
  features {
  }
}

data "azurerm_client_config" "current" {}
