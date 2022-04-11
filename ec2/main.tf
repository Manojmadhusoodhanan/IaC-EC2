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
  
  provisioner "local-exec" {
    command = "echo ${self.private_ip} >> /tmp/private_ips.txt; cat /tmp/private_ips.txt"
    command = "mkdir -p /tmp/test-tf"
    command = "cp /tmp/private_ips.txt /tmp/test-tf; ls -l /tmp/test-tf"
  }
  
  provisioner "file" {
    content = "Hello World"
    destination = "/tmp/helloworld.txt"
    
    connection {
      type = "ssh"
      user = "ec2-user"
      private_key = file("./sony_aws.pem")
      host = self.public_ip
    }    
  }

  tags = {
    Name = "app_server1"
  }
}
