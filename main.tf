resource "aws_vpc" "main" {
  cidr_block       = var.vpc-main
  instance_tenancy = "default"

  tags = {
    Name = "main"
  }
}

## Private & Public Subnet ##

resource "aws_subnet" "myPublicSubnet-1" {
  cidr_block        = "10.16.1.0/24"
  availability_zone = var.availability_zone_1
  vpc_id            = aws_vpc.main.id
  tags = {
    Name = "myPublicSubnet-1"
  }
}

resource "aws_subnet" "myPublicSubnet-2" {
  cidr_block        = "10.16.2.0/24"
  availability_zone = var.availability_zone_2
  vpc_id            = aws_vpc.main.id
  tags = {
    Name = "myPublicSubnet-2"
  }
}


resource "aws_subnet" "myPrivateSubnet-1" {
  cidr_block        = "10.16.16.0/20"
  availability_zone = var.availability_zone_1
  vpc_id            = aws_vpc.main.id
  tags = {
    Name = "myPrivateSubnet-1"
  }
}


resource "aws_subnet" "myPrivateSubnet-2" {
  cidr_block        = "10.16.32.0/20"
  availability_zone = var.availability_zone_2
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

