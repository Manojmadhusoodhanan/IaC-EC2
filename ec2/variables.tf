data "aws_ami" "rhel" {
  most_recent = true
  owners = ["769417893008"]
  filter {
    name = "name"
    values = ["redHat-*"]
  }
  filter {
    name = "root-device-type"
    values = ["ebs"]
  }
  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name = "architecture"
    values = ["x86_64"]
  }
}
variable "region" {
  type = string
  default = "ap-south-1"
}

variable "user" {
  type = string
  default = "ec2-user"
}
