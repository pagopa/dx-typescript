# Review each value of this file and update it according to your needs.

locals {
  prefix          = "dx"
  env_short       = "d"
  location        = "italynorth"
  domain          = "typescript"
  instance_number = "01"

  adgroups = {
    admins_name = "io-p-adgroup-admin"
    devs_name   = "io-p-adgroup-developers"
  }

  runner = {
    cae_name                = "${local.prefix}-${local.env_short}-itn-github-runner-cae-01"
    cae_resource_group_name = "${local.prefix}-${local.env_short}-itn-github-runner-rg-01"
    secret = {
      kv_name                = "${local.prefix}-${local.env_short}-itn-common-kv-01"
      kv_resource_group_name = "${local.prefix}-${local.env_short}-itn-common-rg-01"
    }
  }

  vnet = {
    name                = "${local.prefix}-${local.env_short}-itn-common-vnet-01"
    resource_group_name = "${local.prefix}-${local.env_short}-itn-network-rg-01"
  }

  tf_storage_account = {
    name                = "tfdevdx"
    resource_group_name = "terraform-state-rg"
  }

  repository = {
    name                = "dx-typescript"
    description         = "Typescript project template for devex initiative."
    topics              = ["typescript", "dx", "devex"]
    reviewers_teams     = ["engineering-team-devex"]
    default_branch_name = "main"
  }

  tags = {
    CreatedBy      = "Terraform"
    Environment    = "Dev"
    BusinessUnit   = "DevEx"
    ManagementTeam = "Developer Experience"
    Source         = "https://github.com/pagopa/dx-typescript/blob/main/infra/bootstrapper"
    CostCenter     = "TS000 - Tecnologia e Servizi"
  }
}
