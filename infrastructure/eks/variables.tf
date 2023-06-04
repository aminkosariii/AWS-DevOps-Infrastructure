variable "eks_cluster_name" {
  type = string
}

variable "vpc_name" {
  type        = string
  description = "Name of VPC"
}

variable "vpc_cidr" {
  type        = string
  description = "The CIDR block for the VPC"
}

variable "private_subnets" {
  type        = list(string)
  description = "a list of CIDRs for private subnets in your VPC, must be set if the cidr variable is defined, needs to have as many elements as there are availability zones"
}

variable "public_subnets" {
  type        = list(string)
  description = "a list of CIDRs for public subnets in your VPC, must be set if the cidr variable is defined, needs to have as many elements as there are availability zones"
}
variable "node_group_name" {
    type = string
    description = "Name of the EKS Node Group"
}

variable "disk_size" {
  description = "Disk Size for Worker Nodes in GiB"
}

variable "capacity_type" {
  type        = string
  description = "type of ec2 instances"
}

variable "desired_nodes" {
  type = number

  description = "Desired number of worker nodes"
}

variable "max_nodes" {
  type = number

  description = "Maximum number of worker nodes"
}

variable "min_nodes" {
  type = number

  description = "Minimum number of worker nodes"
}

variable "max_unavailable" {
  type = number

  description = "Number of instance can be unavailable during updates"
}


variable "instance_types" {
  type        = string
  description = "List of instance types associated with the EKS Node Group"
}




