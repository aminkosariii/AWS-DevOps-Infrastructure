provider "helm" {
  kubernetes {
    host                   = aws_eks_cluster.cluster.endpoint
    cluster_ca_certificate = base64decode(aws_eks_cluster.cluster.certificate_authority[0].data)

    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["eks", "get-token", "--cluster-name", aws_eks_cluster.cluster.id]
      command     = "aws"
    }
  }
}

resource "aws_iam_role" "eks-cluster" {
  name = var.eks_cluster_name

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "amazon-eks-cluster-policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks-cluster.name
}
resource "aws_iam_role_policy_attachment" "AmazonEKSServicePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = aws_iam_role.eks-cluster.name
}

locals {
    all_subnets = concat(var.public_subnets, var.private_subnets)
}
resource "aws_eks_cluster" "cluster" {
  name     = var.eks_cluster_name
  version  = "1.27"
  role_arn = aws_iam_role.eks-cluster.arn
  enabled_cluster_log_types = ["api", "audit", "authenticator","controllerManager","scheduler"]

  vpc_config {
    endpoint_private_access = true
    endpoint_public_access  = true
    public_access_cidrs     = ["0.0.0.0/0"]
    subnet_ids = local.all_subnets
  }

  depends_on = [
    aws_iam_role_policy_attachment.amazon-eks-cluster-policy,
    aws_iam_role_policy_attachment.AmazonEKSServicePolicy
  ]
}

