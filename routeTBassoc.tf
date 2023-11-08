# Route table association for Public Addr #

resource "aws_route_table_association" "PublicRtassociation-1" {
  subnet_id      = aws_subnet.myPublicSubnet-1.id
  route_table_id = aws_route_table.myPublicRouteTable.id
}

resource "aws_route_table_association" "PublicRtassociation-2" {
  subnet_id      = aws_subnet.myPublicSubnet-2.id
  route_table_id = aws_route_table.myPublicRouteTable.id
}

# Route table association for Private Addr #

resource "aws_route_table_association" "PrivateRTassociation-1" {
  subnet_id      = aws_subnet.myPrivateSubnet-1.id
  route_table_id = aws_route_table.myPrivateRouteTable-1.id
}

resource "aws_route_table_association" "PrivateRTassociation-2" {
  subnet_id      = aws_subnet.myPrivateSubnet-2.id
  route_table_id = aws_route_table.myPrivateRouteTable-2.id
}
