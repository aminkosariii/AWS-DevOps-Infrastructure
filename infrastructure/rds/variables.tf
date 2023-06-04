variable "vpc_id" {
  description = "EKS Cluster Vpc Id"
}
variable "vpc_cidr" {
    type = string
    description = "VPC CIDR Block"
}



variable "database_name" {
  description = "The name of the initial database to create in the RDS cluster."
}

variable "master_username" {
  description = "The username for the master user of the RDS cluster."
}

variable "master_password" {
  description = "The password for the master user of the RDS cluster."
}

/* variable "rds_instance_type" {
  description = "The instance type for the RDS cluster instances."
} */

/* variable "rds_instance_count" {
  description = "The number of instances to create in the RDS cluster."
} */

/* variable "rds_subnet_ids" {
    type = list(string)
    description = "Subnets ID's for RDS access to network"
} */

/* variable "subnet_ids" {
  description = "A list of subnet IDs where the RDS cluster instances will be created."
  type        = list(string)
} */

/* variable "security_group_ids" {
  description = "A list of security group IDs for the RDS cluster instances."
  type        = list(string)
} */

variable "backup_retention_period" {
  description = "The number of days to retain automated backups."
}

variable "preferred_backup_window" {
  description = "The daily time range during which automated backups are created."
}

variable "preferred_maintenance_window" {
  description = "The weekly time range during which maintenance can occur."
}
