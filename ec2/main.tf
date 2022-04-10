terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"
  region  = "us-west-2"
}

resource "aws_instance" "app_server" {
  ami           = "ami-0b28dfc7adc325ef4"
  instance_type = "t2.micro"
  key_name = "sony_aws"
  
  provisioner "file" {
    content = "Hello World"
    destination = "/tmp/helloworld.txt"
  }

  tags = {
    Name = "app_server1"
  }
}
