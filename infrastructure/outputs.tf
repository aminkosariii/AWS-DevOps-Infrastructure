output "vpc_id" {
  value = module.network.vpc_id
}

output "aws_subnets_private" {
  value = module.network.aws_subnets_private
}

output "aws_subnets_public" {
  value = module.network.aws_subnets_public
}

output "cluster_endpoint" {
  value = module.eks_cluster.cluster_endpoint
}
