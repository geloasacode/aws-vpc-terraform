# NAT Gateway #

resource "aws_nat_gateway" "natGW-1" {
  allocation_id = aws_eip.lb-1.id
  subnet_id     = aws_subnet.myPublicSubnet-1.id

  tags = {
    Name = "natGW-1"
  }
  depends_on = [aws_internet_gateway.myInternetGateway]
}

resource "aws_nat_gateway" "natGW-2" {
  allocation_id = aws_eip.lb-2.id
  subnet_id     = aws_subnet.myPublicSubnet-2.id

  tags = {
    Name = "natGW-2"
  }
  depends_on = [aws_internet_gateway.myInternetGateway]
}
