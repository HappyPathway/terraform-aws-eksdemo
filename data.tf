locals {
  app_name = "${var.network_name}-${var.env}"
}

data "tfe_ip_ranges" "addresses" {}