provider "kubernetes" {
  host                   = aws_eks_cluster.eksdemo.endpoint
  cluster_ca_certificate = base64decode(aws_eks_cluster.eksdemo.certificate_authority[0].data)
  exec {
    api_version = "client.authentication.k8s.io/v1alpha1"
    args        = ["eks", "get-token", "--cluster-name", "eksdemo"]
    command     = "aws"
  }
}

