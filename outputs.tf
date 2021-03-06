
output "endpoint" {
  value = aws_eks_cluster.eks.endpoint
}

output "kubeconfig-certificate-authority-data" {
  value = aws_eks_cluster.eks.certificate_authority[0].data
}

output "vpc_config" {
  value = aws_eks_cluster.eks.vpc_config
}

output bastion {
  value = module.bastion.bastion_host
}