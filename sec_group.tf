
resource "aws_security_group_rule" "sec" {
  type        = "ingress"
  from_port   = 443
  to_port     = 443
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"] # data.tfe_ip_ranges.addresses.api
  # ipv6_cidr_blocks  = [aws_vpc.example.ipv6_cidr_block]
  security_group_id = aws_eks_cluster.eks.vpc_config[0].cluster_security_group_id
}