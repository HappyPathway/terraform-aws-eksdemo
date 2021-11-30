terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "roknsound"

    workspaces {
      name = "EKSDemo"
    }
  }
}
