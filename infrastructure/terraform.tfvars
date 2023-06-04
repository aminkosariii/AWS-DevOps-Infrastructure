#provider
region     = "eu-central-1"
access_key = "AWSAccessKeyId"
secret_key = "AWSSecretKey"


#network
vpc_name           = "parvin-eks-vpc"
vpc_cidr           = "10.0.0.0/16"
cidr_block_igw     = "0.0.0.0/0"
eks_cluster_name   = "parvin-eks-cluster"
private_subnets    = ["10.0.0.0/20", "10.0.32.0/20", "10.0.64.0/20"]
public_subnets     = ["10.0.16.0/20", "10.0.48.0/20", "10.0.80.0/20"]
availability_zones = ["eu-central-1a", "eu-central-1b"]


# node group
# eks_node_group  = "parvin_node_group" 
instance_types  = ["t3.medium"]
disk_size       = 10
desired_nodes   = 3
max_nodes       = 5
min_nodes       = 3
max_unavailable = 2
capacity_type   = "SPOT"
node_group_name = "parvin_node_group"


#rds
security_group               = "rds_cluster_sg"
database_name                = "parvin-database"
master_username              = "parvinuser"
master_password              = "parvinpassword"
backup_retention_period      = 7
preferred_backup_window      = "05:00-07:00"
preferred_maintenance_window = "sun:05:00-sun:06:00"
rds_instance_type            = "db.t2.small"
allocated_storage            = ""
rds_subnet_ids = ""
rds_availability_zones = ["eu-central-1a", "eu-central-1b"]

#ecr
repository_name = ["parvin-staging", "parvin-production"]

