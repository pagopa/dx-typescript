locals {
  project = "${var.prefix}-${var.env_short}"

  ci_github_federations = tolist([
    for env in var.github_environments : [
      for repo in var.continuos_integration.repositories : {
        repository = repo
        subject    = "${env}-ci"
      }
    ]
  ])

  cd_github_federations = tolist([
    for env in var.github_environments : [
      for repo in var.continuos_delivery.repositories : {
        repository = repo
        subject    = "${env}-cd"
      }
    ]
  ])
}
