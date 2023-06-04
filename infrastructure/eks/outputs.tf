output "id" {
    value = aws_eks_node_group.private-nodes.id
}
output "cluster_id" {
  value = aws_eks_cluster.cluster.id
}

output "cluster_name" {
  value = aws_eks_cluster.cluster.name
}

output "oidc_url" {
  value = aws_eks_cluster.cluster.identity[0].oidc[0].issuer
}

output "ca_certificate" {
  value = aws_eks_cluster.cluster.certificate_authority.0.data
}

output "endpoint" {
  value = aws_eks_cluster.cluster.endpoint
}

output "oidc_arn" {
  value = aws_iam_openid_connect_provider.oidc_provider.arn
}

output "cluster_endpoint" {
  value = aws_eks_cluster.cluster.endpoint
}
