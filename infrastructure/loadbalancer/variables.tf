variable "region" {
    type = string
    description = "AWS Region"
}

variable "vpc_id" {
    type = string
    description = "EKS Cluster VPC ID"
}

variable "vpc_cidr" {
    type = string
    description = "VPC CIDR Block"
}

variable "eks_cluster_name" {
    description = "Name of the EKS Cluster"
}

variable "eks_cluster_endpoint" {
    description = "EKS Cluster Endpoint"
}

variable "eks_ca_certificate" {
    description = "EKS Cluster CA Certificate"
}

variable "eks_oidc_url" {
    description = "EKS Cluster OIDC URL"  
}

variable "eks_cluster_id" {
    description = "EKS Cluster ID"
}