provider "aws" {
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}

provider "kubernetes" {
  host                   = var.eks_cluster_endpoint
  cluster_ca_certificate = base64decode(var.eks_ca_certificate)
  token                  = data.aws_eks_cluster_auth.cluster.token
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.2.3"
    }

    external = {
      source  = "hashicorp/external"
      version = "2.2.2"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.11"
    }

    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.6"
    }

  }
}

