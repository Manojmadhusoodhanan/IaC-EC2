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
  region  = var.region
}

resource "aws_key_pair" "sony_aws" {
  public_key = file("./sony_aws.pub")
  key_name = "sony_aws"
}

resource "time_sleep" "wait_3_minutes" {
  depends_on = [aws_key_pair.sony_aws]
  create_duration = "3m"
}

resource "aws_instance" "app_server" {
  ami           = var.ami
  instance_type = "t2.micro"
  count = 1
  key_name = "sony_aws"
  depends_on = [time_sleep.wait_3_minutes]
  
  provisioner "local-exec" {
    command = "echo ${self.private_ip} >> /tmp/private_ips.txt; ls -l /tmp/private_ips.txt"
  }
  
  provisioner "file" {
    content = "Hello World"
    destination = "/tmp/helloworld.txt"
    
    connection {
      type = "ssh"
      user = var.user
      private_key = file("./sony_aws.pem")
      host = self.public_ip
      timeout = "5m"
    }    
  }

  tags = {
    Name = "app_server1"
  }
}
