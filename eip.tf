# Elastic IPs #

resource "aws_eip" "lb-1" {
  domain = "vpc"
}

resource "aws_eip" "lb-2" {
  domain = "vpc"
}
