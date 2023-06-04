resource "aws_eip" "nat_eip" {
  count = length(var.private_subnets)
  vpc   = true
  tags  = {
    Name = "nat-eip-${var.vpc_name}"
  }
}

resource "aws_nat_gateway" "nat" {
  count         = length(var.private_subnets)
  allocation_id = element(aws_eip.nat_eip.*.id, count.index)
  subnet_id     = element(aws_subnet.pub_subnet.*.id, count.index)
  depends_on    = [ aws_internet_gateway.ig ]

  tags = {
    Name = "${var.vpc_name}-nat-${format("%03d", count.index + 1)}"
  }
}
