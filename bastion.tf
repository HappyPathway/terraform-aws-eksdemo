module "bastion" {
  source           = "app.terraform.io/roknsound/bastion/aws"
  version          = "1.0.7"
  admin_sg         = aws_eks_cluster.eks.vpc_config[0].cluster_security_group_id
  key_name         = var.key_name
  network_name     = var.network_name
  public_subnet_id = element(module.public-subnet.*.subnet_id, 0)
  ssh_access       = "0.0.0.0/0"
  vpc_id           = module.vpc.vpc_id
  # insert required variables here
}