resource "aws_eks_cluster" "eks" {
  name     = local.app_name
  role_arn = aws_iam_role.air.arn

  vpc_config {
    subnet_ids = module.public-subnet.*.subnet_id
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    aws_iam_role_policy_attachment.eks-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.eks-AmazonEKSVPCResourceController,
  ]
}
