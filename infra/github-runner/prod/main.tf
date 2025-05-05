terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "terraform-state-rg"
    storage_account_name = "tfproddx"
    container_name       = "terraform-state"
    key                  = "dx-typescript.github-runner.prod.westeurope.tfstate"
    use_azuread_auth     = true
  }
}

provider "azurerm" {
  features {
  }
  storage_use_azuread = true
}

module "container_app_job_selfhosted_runner" {
  source  = "pagopa-dx/github-selfhosted-runner-on-container-app-jobs/azurerm"
  version = "~> 1.0"

  container_app_environment = {
    id       = data.azurerm_container_app_environment.github_runner_cae.id
    location = data.azurerm_container_app_environment.github_runner_cae.location
  }

  environment = {
    prefix          = local.prefix
    env_short       = local.env_short
    location        = local.location
    instance_number = local.instance_number
  }

  repository = {
    name = local.repo_name
  }

  key_vault = {
    name                = "${local.prefix}-${local.env_short}-itn-common-kv-01"
    resource_group_name = "${local.prefix}-${local.env_short}-itn-common-rg-01"
    use_rbac            = true
  }

  tags = local.tags
}

