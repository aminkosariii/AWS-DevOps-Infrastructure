resource "aws_security_group" "sg_rds_mysql" {
  description = "Security Group to allow NFS"
  name = "parvin-eks-rds-sg"
  vpc_id = var.vpc_id

  ingress {
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    cidr_blocks = [ var.vpc_cidr ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_subnet_group" "rds" {
  name       = "parvin-rds-subnet-group"
  subnet_ids =  ["10.0.0.0/20", "10.0.32.0/20", "10.0.64.0/20"]

  tags = {
    Name = "parvin-rds-subnet-group"
  }
}

resource "aws_rds_cluster" "rds_cluster" {
  cluster_identifier           = "parvin-rds-cluster"
  engine                       = "aurora-mysql"
  engine_version               = "5.7.mysql_aurora.2.07.2"
  database_name                = var.database_name
  master_username              = var.master_username
  master_password              = var.master_password
  backup_retention_period      = var.backup_retention_period
  preferred_backup_window      = var.preferred_backup_window
  preferred_maintenance_window = var.preferred_maintenance_window
  db_subnet_group_name         = aws_db_subnet_group.rds.name
  vpc_security_group_ids  = [aws_security_group.sg_rds_mysql.id]
  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.rds_cluster.name
  replication_source_identifier = aws_rds_cluster_instance.rds_cluster_instance[0].identifier
  storage_type              = "io1"
  allocated_storage         = 100
  iops                      = 1000
  availability_zones        = ["eu-central-1a", "eu-central-1b"]
  
  scaling_configuration {
    auto_pause               = true
    max_capacity             = 3
    min_capacity             = 2
    seconds_until_auto_pause = 300
  }

  timeouts {
    create = "60m"
    delete = "120m"
  }

  tags = {
    Name = "parvin-cluster"
  }
}

resource "aws_rds_cluster_instance" "rds_cluster_instance" {
  count                       = 2
  identifier                  = "${var.cluster_name}-instance-${count.index}"
  instance_class           = "db.t2.small"
  engine                      = "aurora-mysql"
  engine_version              = "5.7.mysql_aurora.2.07.2"
  db_subnet_group_name        = aws_db_subnet_group.rds_cluster.name
  vpc_security_group_ids  = [aws_security_group.sg_rds_mysql.id]
  db_group_name     = aws_rds_cluster_parameter_group.rds_cluster.name
  db_cluster_identifier       = aws_rds_cluster.rds_cluster.id
  
  availability_zone        = element(aws_rds_cluster.rds_cluster.availability_zones, count.index)
  preferred_backup_window  = var.preferred_backup_window

  timeouts {
    create = "60m"
    delete = "120m"
  }

  tags = {
    Name = "parvin-cluster"
  }
}
