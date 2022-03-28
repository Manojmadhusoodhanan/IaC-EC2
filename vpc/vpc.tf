resource "aws_vpc" "tfvpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags   = {
    Name = tfvpc
  }
}

resource "aws_subnet" "tfpublic_subnet" {
  count                   = length(var.cidr_block)
  vpc_id                  = aws_vpc.tfvpc.id
  cidr_block              = ["10.0.1.0/24", "10.0.2.0/24"]
  map_public_ip_on_launch = true
  availability_zone       = ["us-west-2a", "us-west-2b", "us-west-2c", "us-west-2d"]
}

resource "aws_subnet" "tfprivate_subnet" {
  count                   = length(var.cidr_block)
  vpc_id                  = aws_vpc.tfvpc.id
  cidr_block              = ["10.0.3.0/24", "10.0.4.0/24"]
  map_private_ip_on_launch = true
  availability_zone       = ["us-west-2a", "us-west-2b", "us-west-2c", "us-west-2d"]
}

resource "aws_igw" "tfigw" {
  vpc_id = aws_vpc.tfvpc.id
  tags   = {
    Name = tfigw
  }
}

resource "aws_rt" "tfpublic_rt" {
  vpc_id = aws_vpc.tfvpc.id
  tags   = {
    Name = tfpublic_rt
  }
}

resource "aws_route" "tfpublic_route" {
  route_table_id         = aws_rt.tfpublic_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_igw.tfigw.id
}

resource "aws_rt_assoc" "tfpublic_assoc" {
  count          = length(var.public_cidrs)
}
