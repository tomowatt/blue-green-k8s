variable "namespace" {
  type = string
}

variable "env_version" {
  type = string
}

variable "image" {
  type = string
}

variable "port" {
  type = number
}

variable "app_configmap" {
  type = map(string)
}
