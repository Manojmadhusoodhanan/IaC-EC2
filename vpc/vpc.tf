resource "aws_vpc" "tfvpc" {
  cidr_block           = var.cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags   = {
    Name = "tfvpc"
  }
}

resource "aws_subnet" "tfpublic_subnet" {
  count                   = length(var.public_cidr)
  vpc_id                  = aws_vpc.tfvpc.id
  cidr_block              = var.public_cidr[count.index]
  map_public_ip_on_launch = true
  availability_zone       = var.az
}

resource "aws_subnet" "tfprivate_subnet" {
  count                    = length(var.private_cidr)
  vpc_id                   = aws_vpc.tfvpc.id
  cidr_block               = var.private_cidr[count.index]
  availability_zone        = var.az
}

resource "aws_internet_gateway" "tfigw" {
  vpc_id = aws_vpc.tfvpc.id
  tags   = {
    Name = "tfigw"
  }
}

resource "aws_route_table" "tfpublic_rt" {
  vpc_id = aws_vpc.tfvpc.id
  tags   = {
    Name = "tfpublic_rt"
  }
}

resource "aws_route_table" "tfprivate_rt" {
  vpc_id = aws_vpc.tfvpc.id
  tags   = {
    Name = "tfprivate_rt"
  }
}

resource "aws_route" "tfpublic_route" {
  route_table_id         = aws_rt.tfpublic_rt.id
  destination_cidr_block = var.dst_cidr
  gateway_id             = aws_igw.tfigw.id
}

resource "aws_route" "tfprivate_route" {
  route_table_id         = aws_rt.tfprivate_rt.id
  destination_cidr_block = var.dst_cidr
}

resource "aws_route_table_association" "tfpublic_assoc" {
  count          = length(var.public_cidr)
  subnet_id      = aws_subnet.tfpublic_subnet.*.id[count.index]
  route_table_id = aws_rt.tfpublic_rt.id
}

resource "aws_route_table_association" "tfprivate_assoc" {
  count          = length(var.private_cidr)
  subnet_id      = aws_subnet.tfprivate_subnet.*.id[count.index]
  route_table_id = aws_rt.tfprivate_rt.id
}
