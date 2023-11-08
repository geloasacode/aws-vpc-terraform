# Route Table #

resource "aws_route_table" "myPublicRouteTable" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.myInternetGateway.id
  }
  tags = {
    Name = "myPublicRouteTable"
  }
}


resource "aws_route_table" "myPrivateRouteTable-1" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.natGW-1.id
  }
  tags = {
    Name = "myPrivateRouteTable"
  }
}

resource "aws_route_table" "myPrivateRouteTable-2" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.natGW-2.id
  }
  tags = {
    Name = "myPrivateRouteTable"
  }
}
