locals {
  project = "${var.prefix}-${var.env_short}"

  # github_environments = concat(
  #   var.continuos_integration.enable == true ? ["ci"] : [],
  #   var.continuos_delivery.enable == true ? ["cd"] : [],
  # )

  ci_github_federations = tolist(flatten([
    # for env in local.github_environments : [
    for repo in var.repositories : {
      repository = repo
      subject    = "ci"
    }
    ]
  ))

  cd_github_federations = tolist(flatten([
    # for env in local.github_environments : [
    for repo in var.repositories : {
      repository = repo
      subject    = "cd"
    }
    ]
  ))
}
