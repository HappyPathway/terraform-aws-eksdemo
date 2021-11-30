module "network" {
  source  = "app.terraform.io/roknsound/network/aws"
  version = "3.1.1"
  # insert required variables here
  key_name     = "eksdemo"
  network_name = "eksdemo"
  region       = "us-east-1"
}