variable "project" {}

variable "environment" {}

variable "cidr_block" {
  type = string
}

variable "enable_private_subnet" {
  type    = bool
  default = true
}

variable "public_subnets" {
  type    = map(string)
  default = {}
}

variable "private_subnets" {
  type    = map(string)
  default = {}
}

variable "enable_dns_support" {
  type    = bool
  default = true
}

variable "enable_dns_hostnames" {
  type    = bool
  default = false
}
