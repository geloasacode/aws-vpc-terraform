# Public Instance #

resource "aws_instance" "myPublicInstance" {
  for_each = {
    "myPublicInstance-1" = {
      subnet_id         = aws_subnet.myPublicSubnet-1.id
      availability_zone = var.availability_zone_1
    }
    "myPublicInstance-2" = {
      subnet_id         = aws_subnet.myPublicSubnet-2.id
      availability_zone = var.availability_zone_2
    }
  }

  ami                         = var.ami-use
  instance_type               = var.instance_type
  associate_public_ip_address = true
  security_groups             = [aws_security_group.myVpcSecurity.id]
  subnet_id                   = each.value.subnet_id
  availability_zone           = each.value.availability_zone
  key_name                    = var.key_pem
  tags = {
    Name = each.key
  }
}


# Private Instance #

resource "aws_instance" "myPrivateInstance" {
  for_each = {
    "myPrivateInstance-1" = {
      subnet_id         = aws_subnet.myPrivateSubnet-1.id
      availability_zone = var.availability_zone_1
    }
    "myPrivateInstance-2" = {
      subnet_id         = aws_subnet.myPrivateSubnet-2.id
      availability_zone = var.availability_zone_2
    }
  }

  ami                         = var.ami-use
  instance_type               = var.instance_type
  associate_public_ip_address = false
  security_groups             = [aws_security_group.myVpcSecurity.id]
  subnet_id                   = each.value.subnet_id
  availability_zone           = each.value.availability_zone
  key_name                    = var.key_pem
  tags = {
    Name = each.key
  }
}
