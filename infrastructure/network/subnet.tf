#Creating Public Subnets
resource "aws_subnet" "pub_subnet" {
  count                   = length(var.public_subnets)
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = element(var.public_subnets, count.index)
  availability_zone       = element(var.availability_zones, count.index)
  map_public_ip_on_launch = true

  tags = {
    Name                                            = "${var.vpc_name}-public-subnet-${(count.index + 1)}"
    "kubernetes.io/cluster/${var.eks_cluster_name}" = "shared"
    "kubernetes.io/role/elb"                        = 1
  }
}

#Creating Private Subnets
resource "aws_subnet" "priv_subnet" {
  count = length(var.private_subnets)

  vpc_id     = aws_vpc.vpc.id
  cidr_block = element(var.private_subnets, count.index)
  availability_zone = element(var.availability_zones, count.index)
  map_public_ip_on_launch = false

  tags = {
    Name                                            = "${var.vpc_name}-private-subnet-${(count.index + 1)}"
    "kubernetes.io/cluster/${var.eks_cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"               = 1
  }
}
