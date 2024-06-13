locals {
  env_short = "d"
  prefix    = "dx"
  location_short = "itn"
  location = "italynorth"

  project   = "${local.prefix}-${local.env_short}-${local.location_short}"

  tags = {
    CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
    CreatedBy   = "Terraform"
    Environment = "Dev"
    Owner       = "DevEx"
    Source      = "https://github.com/pagopa/dx-typescript/blob/main/infra/resources/dev/italynorth"
  }
}