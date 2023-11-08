# Security Group #

resource "aws_security_group" "myVpcSecurity" {
  name        = "vpc-publicSubnet1"
  vpc_id      = aws_vpc.main.id
  description = "Security Group for Public Subnet-1"

  ingress {
    description = "HTTP to VPC"
    from_port   = var.ingress-http
    to_port     = var.ingress-http
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH to Instance inside VPC"
    from_port   = var.ingress-ssh
    to_port     = var.ingress-ssh
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow outgoing traffic to all"
    from_port   = var.egress-all
    to_port     = var.egress-all
    protocol    = "all"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "Security Group for Public Subnet"
  }
}
