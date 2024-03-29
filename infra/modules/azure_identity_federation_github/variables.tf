# variable "location" {
#   type        = string
#   description = "Azure region"
# }

variable "tags" {
  type        = map(any)
  description = "Resources tags"
}

variable "env_short" {
  type        = string
  description = "Environment short name"
}

variable "prefix" {
  type        = string
  description = "Project prefix"
}

variable "domain" {
  type        = string
  default     = ""
  description = "(Optional) Domain of the project"
}

variable "github_environments" {
  type        = list(string)
  description = "List of GitHub environment name suffix"
}

variable "repositories" {
  type        = list(string)
  description = "List of repositories to federate"
}

variable "continuos_integration" {
  type = object({
    enable = bool
    # repositories = list(string)
    roles = object({
      subscription    = set(string)
      resource_groups = map(list(string))
    })
  })
  description = "Continuos Integration identity properties, such as repositories to federated with and RBAC roles"
}

variable "continuos_delivery" {
  type = object({
    enable = bool
    # repositories = list(string)
    roles = object({
      subscription    = set(string)
      resource_groups = map(list(string))
    })
  })
  description = "Continuos Delivery identity properties, such as repositories to federated with and RBAC roles"
}
