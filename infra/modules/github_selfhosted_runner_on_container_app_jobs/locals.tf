locals {
  key_vault = {
    name                = var.prefix == "io" ? "${var.prefix}-${var.env_short}-kv-common" : "${var.prefix}-${var.env_short}-kv"
    resource_group_name = var.prefix == "io" ? "${var.prefix}-${var.env_short}-rg-common" : "${var.prefix}-${var.env_short}-sec-rg"
  }

  container_app_environment = {
    name                = "${var.prefix}-${var.env_short}-github-runner-cae"
    resource_group_name = "${var.prefix}-${var.env_short}-github-runner-rg"
  }
}
