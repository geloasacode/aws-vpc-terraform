resource "aws_vpc" "main" {
  cidr_block       = "10.16.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "main"
  }
}

## Private & Public Subnet ##

resource "aws_subnet" "myPublicSubnet-1" {
  cidr_block        = "10.16.1.0/24"
  availability_zone = "us-east-1a"
  vpc_id            = aws_vpc.main.id
  tags = {
    Name = "myPublicSubnet-1"
  }
}

resource "aws_subnet" "myPublicSubnet-2" {
  cidr_block        = "10.16.2.0/24"
  availability_zone = "us-east-1b"
  vpc_id            = aws_vpc.main.id
  tags = {
    Name = "myPublicSubnet-2"
  }
}


resource "aws_subnet" "myPrivateSubnet-1" {
  cidr_block        = "10.16.16.0/20"
  availability_zone = "us-east-1a"
  vpc_id            = aws_vpc.main.id
  tags = {
    Name = "myPrivateSubnet-1"
  }
}


resource "aws_subnet" "myPrivateSubnet-2" {
  cidr_block        = "10.16.32.0/20"
  availability_zone = "us-east-1b"
  vpc_id            = aws_vpc.main.id
  tags = {
    Name = "myPrivateSubnet-2"
  }
}


#### Internet Gateway ####

resource "aws_internet_gateway" "myInternetGateway" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "myInternetGateway"
  }
}

#### Elastic IP #####

resource "aws_eip" "lb-1" {
  domain = "vpc"
}

resource "aws_eip" "lb-2" {
  domain = "vpc"
}


#### NAT Gateway ####


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

#### Route Table ####

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

#### Route table association for Public Addr ####

resource "aws_route_table_association" "PublicRtassociation" {
  subnet_id      = aws_subnet.myPublicSubnet-1.id
  route_table_id = aws_route_table.myPublicRouteTable.id
}

#### Route table association for Private Addr ####

resource "aws_route_table_association" "PrivateRTassociation-1" {
  subnet_id      = aws_subnet.myPrivateSubnet-1.id
  route_table_id = aws_route_table.myPrivateRouteTable-1.id
}

resource "aws_route_table_association" "PrivateRTassociation-2" {
  subnet_id      = aws_subnet.myPrivateSubnet-2.id
  route_table_id = aws_route_table.myPrivateRouteTable-2.id
}


### Ec2 Public instance ###

resource "aws_instance" "myPublicInstance" {
  for_each = {
    "myPublicInstance-1" = {
      subnet_id         = aws_subnet.myPublicSubnet-1.id
      availability_zone = "us-east-1a"
    }
    "myPublicInstance-2" = {
      subnet_id         = aws_subnet.myPublicSubnet-2.id
      availability_zone = "us-east-1b"
    }
  }

  ami                         = "ami-05c13eab67c5d8861"
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  security_groups             = [aws_security_group.myVpcSecurity.id]
  subnet_id                   = each.value.subnet_id
  availability_zone           = each.value.availability_zone
  key_name                    = "terraform-cicd"
  tags = {
    Name = each.key
  }
}

### Ec2 Private instance ###

resource "aws_instance" "myPrivateInstance" {
  for_each = {
    "myPrivateInstance-1" = {
      subnet_id         = aws_subnet.myPrivateSubnet-1.id
      availability_zone = "us-east-1a"
    }
    "myPrivateInstance-2" = {
      subnet_id         = aws_subnet.myPrivateSubnet-2.id
      availability_zone = "us-east-1b"
    }
  }

  ami                         = "ami-05c13eab67c5d8861"
  instance_type               = "t2.micro"
  associate_public_ip_address = false
  security_groups             = [aws_security_group.myVpcSecurity.id]
  subnet_id                   = each.value.subnet_id
  availability_zone           = each.value.availability_zone
  key_name                    = "terraform-cicd"
  tags = {
    Name = each.key
  }
}


### security group for Ec2 ###

resource "aws_security_group" "myVpcSecurity" {
  name        = "vpc-publicSubnet1"
  vpc_id      = aws_vpc.main.id
  description = "Security Group for Public Subnet-1"

  ingress {
    description = "HTTP to VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH to Instance inside VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow outgoing traffic to all"
    from_port   = 0
    to_port     = 0
    protocol    = "all"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "Security Group for Public Subnet"
  }
}

output "ElasticIP-1" {
  value = aws_eip.lb-1.public_ip
}

output "NatGateway-1" {
  value = aws_nat_gateway.natGW-1.public_ip
}

output "ElasticIP-2" {
  value = aws_eip.lb-2.public_ip
}

output "NatGateway-2" {
  value = aws_nat_gateway.natGW-2.public_ip
}

