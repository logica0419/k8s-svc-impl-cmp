terraform {
  required_version = "1.14.8"

  required_providers {
    sakuracloud = {
      source  = "sacloud/sakuracloud"
      version = "2.35.0"
    }
    http = {
      source  = "hashicorp/http"
      version = "3.5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.8.1"
    }
  }

  backend "local" {}
}

data "sakuracloud_archive" "ubuntu_archive" {
  os_type = "ubuntu2204"
}

data "http" "key" {
  url = "https://github.com/logica0419.keys"
}

resource "random_password" "cluster_pass" {
  length           = 64
  special          = true
  override_special = "!@#&*()-_=+[]:,.?"
}
