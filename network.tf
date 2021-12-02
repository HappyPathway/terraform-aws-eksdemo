module "network" {
  source  = "app.terraform.io/roknsound/network/aws"
  version = "~> 3.1"
  # insert required variables here
  key_name     = aws_key_pair.deployer.key_name
  network_name = local.app_name
  region       = "us-east-1"
}

#
module "vpc" {
  source       = "app.terraform.io/roknsound/vpc/aws"
  version      = "~> 2.0"
  vpc_cidr     = var.vpc_cidr
  network_name = local.app_name
}

module "public-subnet" {
  source            = "app.terraform.io/roknsound/public-subnet/aws"
  version           = "~> 1.0"
  count             = length(var.public_subnet_cidrs)
  vpc_id            = module.vpc.vpc_id
  route_table_id    = module.vpc.route_table_id
  availability_zone = element(var.availability_zones, count.index)
  network_name      = "${local.app_name}-public"
  subnet_cidr       = element(var.public_subnet_cidrs, count.index)
}

module "private-subnet" {
  source            = "app.terraform.io/roknsound/private-subnet/aws"
  version           = "~> 1.0"
  count             = length(var.private_subnet_cidrs)
  vpc_id            = module.vpc.vpc_id
  public_subnet_id  = element(module.public-subnet.*.subnet_id, count.index)
  availability_zone = element(var.availability_zones, count.index)
  network_name      = "${local.app_name}-private"
  subnet_cidr       = element(var.private_subnet_cidrs, count.index)
}
