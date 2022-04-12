provider "aws" {
  profile = "default"
  region  = var.region
}

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
  availability_zone       = ["us-west-2a", "us-west-2b", "us-west-2c", "us-west-2d"][count.index]
}

resource "aws_subnet" "tfprivate_subnet" {
  count                    = length(var.private_cidr)
  vpc_id                   = aws_vpc.tfvpc.id
  cidr_block               = var.private_cidr[count.index]
  availability_zone        = ["us-west-2a", "us-west-2b", "us-west-2c", "us-west-2d"][count.index]
}

resource "aws_internet_gateway" "tfigw" {
  vpc_id = aws_vpc.tfvpc.id
  
  tags   = {
    Name = "tfigw"
  }
}

resource "aws_eip" "tfeip" {
  vpc    = true
  
  tags   = {
    Name = "tfeip"
  }
}

resource "aws_nat_gateway" "tfnat" {
  allocation_id = "${aws_eip.tfeip.id}"
  subnet_id     = "${aws_subnet.tfpublic_subnet.0.id}"
  
  tags = {
    Name = "tfnat"
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
  route_table_id         = aws_route_table.tfpublic_rt.id
  destination_cidr_block = var.dst_cidr
  gateway_id             = aws_internet_gateway.tfigw.id
}

resource "aws_route" "tfprivate_route" {
  route_table_id         = aws_route_table.tfprivate_rt.id
  destination_cidr_block = var.dst_cidr
  nat_gateway_id         = aws_nat_gateway.tfnat.id
}

resource "aws_route_table_association" "tfpublic_assoc" {
  count          = length(var.public_cidr)
  subnet_id      = aws_subnet.tfpublic_subnet.*.id[count.index]
  route_table_id = aws_route_table.tfpublic_rt.id
}

resource "aws_route_table_association" "tfprivate_assoc" {
  count          = length(var.private_cidr)
  subnet_id      = aws_subnet.tfprivate_subnet.*.id[count.index]
  route_table_id = aws_route_table.tfprivate_rt.id
}
