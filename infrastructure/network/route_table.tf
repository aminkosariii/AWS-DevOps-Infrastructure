#Route Table for Public Subnets
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "eks-public-rt"
  }
}

resource "aws_route" "public" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.ig.id
}

resource "aws_route_table_association" "public" {
  count          = length(var.public_subnets)
  subnet_id      = element(aws_subnet.pub_subnet.*.id, count.index)
  route_table_id = aws_route_table.public.id
}


#Route Table for Private Subnets
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.vpc.id
  count  = length(var.private_subnets)
  tags = {
    Name = "eks-private-rt"
  }
}

resource "aws_route" "private" {
  count                  = length(compact(var.private_subnets))
  route_table_id         = element(aws_route_table.private.*.id, count.index)
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = element(aws_nat_gateway.nat.*.id, count.index)
}

resource "aws_route_table_association" "private" {
  count          = length(var.private_subnets)
  subnet_id      = element(aws_subnet.priv_subnet.*.id, count.index)
  route_table_id = element(aws_route_table.private.*.id, count.index)
}
