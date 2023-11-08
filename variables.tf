variable "vpc-main" {}
variable "ingress-http" {}
variable "ingress-ssh" {}
variable "egress-all" {}
variable "ami-use" {}
variable "key_pem" {}
variable "instance_type" {}
variable "availability_zone_1" {}
variable "availability_zone_2" {}


output "aws_vpc_main" {
  value = aws_vpc.main.cidr_block
}
