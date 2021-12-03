data "aws_subnet" "selected" {
  id = element(module.public-subnet.*.subnet_id, 0)
}

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

  # kubernetes_network_config {
  #   service_ipv4_cidr = data.aws_subnet.selected.cidr_block
  # }
}



resource "aws_eks_node_group" "eks_nodes" {
  cluster_name    = aws_eks_cluster.eks.name
  node_group_name = "eks-node-group-${local.app_name}"
  node_role_arn   = aws_iam_role.eks_nodes.arn # aws_iam_role" "eks_nodes
  subnet_ids      = module.public-subnet.*.subnet_id

  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 1
  }

  update_config {
    max_unavailable = 2
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.eks-node-group-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.eks-node-group-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.eks-node-group-AmazonEC2ContainerRegistryReadOnly,
  ]
}