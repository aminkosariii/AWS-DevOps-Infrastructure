data "aws_eks_cluster_auth" "eks_auth" {
  name = var.eks_cluster_name
}

data "aws_eks_cluster" "cluster" {
  name = var.eks_cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = var.eks_cluster_id
}

provider "helm" {
  debug      = true

  kubernetes {
    host                   = var.eks_cluster_endpoint
    cluster_ca_certificate = base64decode(var.eks_ca_certificate)
    exec {
      api_version = "client.authentication.k8s.io/v1alpha1"
      args        = ["eks", "get-token", "--cluster-name", var.eks_cluster_name]
      command     = "aws"
    }
  }
}

provider "kubernetes" {
  host                   = var.eks_cluster_endpoint
  cluster_ca_certificate = base64decode(var.eks_ca_certificate)
  token                  = data.aws_eks_cluster_auth.cluster.token
}

data "aws_caller_identity" "current" {}

data "http" "iam_policy" {
  url = "https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/v2.4.1/docs/install/iam_policy.json"
  request_headers = {
    Accept = "application/json"
  }
}

resource "aws_iam_policy" "AWSLoadBalancerControllerIAMPolicy" {
  name = "AWSLoadBalancerControllerIAMPolicy"
  policy = data.http.iam_policy.response_body
}

data "aws_iam_policy_document" "elb_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(var.eks_oidc_url, "https://", "")}:sub"
      values   = ["system:serviceaccount:kube-system:aws-load-balancer-controller"]
    }

    principals {
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/${replace(var.eks_oidc_url, "https://", "")}"]
      type        = "Federated"
    }
  }
}

resource "aws_iam_role" "eks_lb_controller" {
  assume_role_policy = data.aws_iam_policy_document.elb_assume_role_policy.json
  name               = "AmazonEKSLoadBalancerControllerRole"
}

resource "aws_iam_role_policy_attachment" "ALBIngressControllerIAMPolicy" {
  policy_arn = aws_iam_policy.AWSLoadBalancerControllerIAMPolicy.arn
  role       = aws_iam_role.eks_lb_controller.name
}

resource "kubernetes_service_account" "load_balancer_Controller" {
  automount_service_account_token = true
  metadata {
    name      = "aws-load-balancer-controller"
    namespace = "kube-system"
    annotations = {
      "eks.amazonaws.com/role-arn" = aws_iam_role.eks_lb_controller.arn
    }
    labels = {
      "app.kubernetes.io/name"       = "aws-load-balancer-controller"
      "app.kubernetes.io/component"  = "controller"
      "app.kubernetes.io/managed-by" = "terraform"
    }
  }
}

resource "kubernetes_cluster_role" "load_balancer_Controller" {
  metadata {
    name = "aws-load-balancer-controller"

    labels = {
      "app.kubernetes.io/name"       = "aws-load-balancer-controller"
      "app.kubernetes.io/managed-by" = "terraform"
    }
  }

  rule {
    api_groups = ["", "extensions"]
    resources  = ["configmaps", "endpoints", "events", "ingresses", "ingresses/status", "services"]
    verbs      = ["create", "get", "list", "update", "watch", "patch"]
  }

  rule {
    api_groups = ["", "extensions"]
    resources  = ["nodes", "pods", "secrets", "services", "namespaces"]
    verbs      = ["get", "list", "watch"]
  }
}

resource "kubernetes_cluster_role_binding" "load_balancer_Controller" {
  metadata {
    name = "aws-load-balancer-controller"

    labels = {
      "app.kubernetes.io/name"       = "aws-load-balancer-controller"
      "app.kubernetes.io/managed-by" = "terraform"
    }
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = kubernetes_cluster_role.load_balancer_Controller.metadata[0].name
  }

  subject {
    api_group = ""
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.load_balancer_Controller.metadata[0].name
    namespace = kubernetes_service_account.load_balancer_Controller.metadata[0].namespace
  }
  depends_on = [ kubernetes_cluster_role.load_balancer_Controller ]
}

resource "helm_release" "using_iamserviceaccount" {
  name       = "aws-load-balancer-controller"
  # repository = "https://aws.github.io/eks-charts"
  chart      = "eks/aws-load-balancer-controller"
  # version    = "1.4.6"
  namespace  = "kube-system"
  atomic     = true

  set {
    name  = "clusterName"
    value = var.eks_cluster_name
  }
  set {
    name  = "serviceAccount.create"
    value = "false"
  }
  set {
    name  = "serviceAccount.name"
    value = "aws-load-balancer-controller"
  }
  set {
    name  = "region"
    value = var.region
  }
  set {
    name  = "vpcId"
    value = var.vpc_id
  }

  depends_on = [kubernetes_cluster_role_binding.load_balancer_Controller]
}