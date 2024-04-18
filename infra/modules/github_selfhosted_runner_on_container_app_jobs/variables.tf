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

variable "repo_name" {
  type = string
}
