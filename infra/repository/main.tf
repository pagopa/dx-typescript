terraform {

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.100.0"
    }

    github = {
      source  = "integrations/github"
      version = "6.1.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "terraform-state-rg"
    storage_account_name = "tfproddx"
    container_name       = "terraform-state"
    key                  = "dx-typescript.repository.tfstate"
  }
}

provider "azurerm" {
  features {
  }
}

provider "github" {
  owner = "pagopa"
}

data "azurerm_client_config" "current" {}

data "azurerm_subscription" "current" {}

data "azurerm_subscription" "dev" {
  subscription_id = "a4e96bcd-59dc-4d66-b2f7-5547ad157c12" # DEV-IO
}
