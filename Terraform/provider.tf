terraform {
  required_providers {
    iosxe = {
      source  = "CiscoDevNet/iosxe"
      version = "0.7.1"
    }
  }
}

variable "username" {}
variable "password" {}
variable "devices" {}
variable "routers" {}

provider "iosxe" {
  username = var.username
  password = var.password
  devices  = var.devices
}