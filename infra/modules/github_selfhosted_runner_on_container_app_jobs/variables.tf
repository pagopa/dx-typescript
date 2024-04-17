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

variable "container_app_environment" {
  type = object({
    name                = string
    resource_group_name = string
  })
}

variable "key_vault" {
  type = object({
    name                = string
    resource_group_name = string
  })
}

variable "repo_name" {
  type = string
}
