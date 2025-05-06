locals {
  prefix          = "dx"
  env_short       = "d"
  repo_name       = "dx-typescript"
  location        = "italynorth"
  instance_number = "01"

  tags = {
    CostCenter     = "TS000 - Tecnologia e Servizi"
    CreatedBy      = "Terraform"
    Environment    = "Dev"
    BusinessUnit   = "DevEx"
    ManagementTeam = "Developer Experience"
    Source         = "https://github.com/pagopa/dx-typescript/blob/main/infra/github-runner/prod/westeurope"
  }
}
