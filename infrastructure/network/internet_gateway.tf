#Creating Internet Gateway
resource "aws_internet_gateway" "ig" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "eks-igw-${var.vpc_name}"
  }
}
