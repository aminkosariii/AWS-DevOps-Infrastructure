# provider
variable "region" {
  type        = string
  description = "the AWS region in which resources are created"
}

variable "access_key" {
  type        = string
  description = "aws access key account"
}

variable "secret_key" {
  type        = string
  description = "aws access key account"
}


#
variable "eks_cluster_endpoint" {
  description = "EKS Cluster Endpoint"
}

variable "eks_ca_certificate" {
  description = "EKS Cluster CA Certificate"
}

variable "eks_cluster_id" {
  description = "EKS Cluster ID"
}
#


#network
variable "vpc_name" {
  type        = string
  description = "Name of VPC"
}

variable "vpc_cidr" {
  type        = string
  description = "The CIDR block for the VPC."
}


# EKS
variable "node_group_name" {
  type        = string
  description = "Name of the EKS Node Group"
}


variable "eks_cluster_name" {
  type        = string
  description = "Name of the EKS Cluster"
}

variable "private_subnets" {
  type        = list(string)
  description = "a list of CIDRs for private subnets in your VPC, must be set if the cidr variable is defined, needs to have as many elements as there are availability zones"
}

variable "public_subnets" {
  type        = list(string)
  description = "a list of CIDRs for public subnets in your VPC, must be set if the cidr variable is defined, needs to have as many elements as there are availability zones"
}

variable "availability_zones" {
  type        = list(string)
  description = "a comma-separated list of availability zones, defaults to all AZ of the region, if set to something other than the defaults, both private_subnets and public_subnets have to be defined as well"
}


variable "instance_types" {
  type        = string
  description = "List of instance types associated with the EKS Node Group"
} 

variable "disk_size" {
  type        = number
  description = "Disk Size for Worker Nodes in GiB"
}

variable "desired_nodes" {
  type        = number
  description = "Desired number of worker nodes"
}

variable "max_nodes" {
  type        = number
  description = "Maximum number of worker nodes"
}

variable "min_nodes" {
  type        = number
  description = "Minimum number of worker nodes"
}

variable "capacity_type" {
  type        = string
  description = "type of ec2 instances"
}

variable "max_unavailable" {
  type        = number
  description = "Number of instance can be unavailable during updates"
}


# rds

variable "database_name" {
  type        = string
  description = "database name"
}


variable "master_username" {
  description = "The username for the master user of the RDS cluster."
}

variable "master_password" {
  description = "The password for the master user of the RDS cluster."
}

/* 
variable "allocated_storage" {
  type        = number
  description = "database storage"
} */


/* variable "rds_instance_type" {
  description = "The instance type for the RDS cluster instances."
} */

/* variable "rds_instance_count" {
  description = "The number of instances to create in the RDS cluster."
} */
/* variable "rds_availability_zones" {
  description = "availability zones for the RDS cluster"
} */

/* variable "rds_subnet_ids" {
  type        = list(string)
  description = "Subnets ID's for RDS access to network"
} */

variable "backup_retention_period" {
  description = "The number of days to retain automated backups."
}

variable "preferred_backup_window" {
  description = "The daily time range during which automated backups are created."
}

variable "preferred_maintenance_window" {
  description = "The daily time range during which automated backups are created."
}


#ecr
variable "repository_name" {
  type        = list(string)
  description = "List of ECR Repositiories"
}
























/* variable "rds_subnet_ids" {
  type        = list(string)
  description = "Subnets ID's for RDS access to network"
} */





/* variable "cidr_block_igw" {
  description = "CIDR Block for Internet and NAT Gateways"
}





variable "kubeconfig_path" {
  description = "Path where the config file for kubectl should be written to"
  default     = "~/.kube"
}

variable "k8s_version" {
  description = "kubernetes version"
  default     = "1.23"
} */

