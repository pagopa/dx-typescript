data "azurerm_container_app_environment" "github_runner_cae" {
  name                = "${local.prefix}-${local.env_short}-itn-github-runner-cae-01"
  resource_group_name = "${local.prefix}-${local.env_short}-itn-github-runner-rg-01"
}
