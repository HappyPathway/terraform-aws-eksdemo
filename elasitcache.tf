resource "aws_elasticache_cluster" "el_cl" {
  cluster_id           = local.app_name
  engine               = "redis"
  node_type            = var.elasticache_cluster_node_type
  num_cache_nodes      = var.elasticache_cluster_num_cache_nodes
  parameter_group_name = var.elasticache_cluster_parameter_group_name
  engine_version       = var.elasticache_cluster_engine_version
  port                 = var.elasticache_cluster_engine_port
}
