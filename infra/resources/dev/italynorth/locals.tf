locals {
  env_short = "d"
  prefix    = "dx"
  project   = "${local.prefix}-${local.env_short}"
  project_compact = "${local.prefix}${local.env_short}"

  location = "italynorth"

  tags = {
    CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
    CreatedBy   = "Terraform"
    Environment = "Dev"
    Owner       = "DevEx"
    Source      = "https://github.com/pagopa/dx-typescript/blob/main/infra/resources/dev/italynorth"
  }
}