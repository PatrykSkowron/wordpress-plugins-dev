variable "tag" {
  default = "wordpress"
}

variable "allowed_ips" {
  type = list(string)
}

variable "deployer_public_key" {
  type = string
}