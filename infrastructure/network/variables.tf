variable "vpc_cidr" {
  type = string
  description = "The CIDR block for the VPC."
}

variable "public_subnets" {
  type = list(string)
  description = "List of public subnets"
}

variable "private_subnets" {
  type = list(string)
  description = "List of private subnets"
}

variable "availability_zones" {
  type = list(string)
  description = "List of availability zones"
}
variable "eks_cluster_name" {
  type = string
  description = "Name of the EKS Cluster"
}
variable "vpc_name" {
  type = string
  description = "Name of VPC"
}
