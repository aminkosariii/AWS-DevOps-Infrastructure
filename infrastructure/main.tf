module "network" {
  source             = "./network"
  vpc_name           = var.vpc_name
  vpc_cidr           = var.vpc_cidr
  eks_cluster_name   = var.eks_cluster_name
  private_subnets    = var.private_subnets
  public_subnets     = var.public_subnets
  availability_zones = var.availability_zones
}

module "eks_cluster" {
  source           = "./eks"
  eks_cluster_name = var.eks_cluster_name
  public_subnets   = module.network.aws_subnets_public
  private_subnets  = module.network.aws_subnets_private
  instance_types   = var.instance_types
  disk_size        = var.disk_size
  desired_nodes    = var.desired_nodes
  max_nodes        = var.max_nodes
  min_nodes        = var.min_nodes
  capacity_type    = var.capacity_type
  max_unavailable  = var.max_unavailable
  vpc_cidr         = var.vpc_cidr
  node_group_name  = var.node_group_name
  vpc_name         = var.vpc_name
}

module "rds" {
  source             = "./rds"
  vpc_id                       = module.network.vpc_id
  vpc_cidr                     = var.vpc_cidr
  master_username              = var.master_username
  master_password              = var.master_password
  database_name                = var.database_name
  backup_retention_period      = var.backup_retention_period
  preferred_backup_window      = var.preferred_backup_window
  preferred_maintenance_window = var.preferred_maintenance_window
}


module "ecr" {
  source          = "./ecr"
  repository_name = var.repository_name
}


module "aws_load_balancer" {
  source               = "./loadbalancer"
  eks_cluster_name     = module.eks_cluster.cluster_name
  region               = var.region
  vpc_id               = module.network.vpc_id
  vpc_cidr             = var.vpc_cidr
  eks_cluster_endpoint = module.eks_cluster.cluster_endpoint
  eks_ca_certificate   = module.eks_cluster.ca_certificate
  eks_oidc_url         = module.eks_cluster.oidc_url
  eks_cluster_id       = module.eks_cluster.cluster_id
}
