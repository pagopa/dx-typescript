# DX Typescript - GitHub SelfHosted Runner on Container App Job

<!-- markdownlint-disable -->
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.86.0, <= 3.99.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.97.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_container_app_job_selfhosted_runner"></a> [container\_app\_job\_selfhosted\_runner](#module\_container\_app\_job\_selfhosted\_runner) | github.com/pagopa/terraform-azurerm-v3//container_app_job_gh_runner | v8.2.0 |

## Resources

| Name | Type |
|------|------|
| [azurerm_container_app_environment.runner](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/container_app_environment) | data source |
| [azurerm_key_vault.kv](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_env_short"></a> [env\_short](#input\_env\_short) | Environment short name | `string` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | Project prefix | `string` | n/a | yes |
| <a name="input_repo_name"></a> [repo\_name](#input\_repo\_name) | n/a | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Resources tags | `map(any)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_container_app_job"></a> [container\_app\_job](#output\_container\_app\_job) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
