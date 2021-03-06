variable "cidr" {
  type = string
  default = "10.0.0.0/16"
}

variable "public_cidr" {
  type = list(any)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_cidr" {
  type = list(any)
  default = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "dst_cidr" {
  type = string
  default = "0.0.0.0/0"
}

variable "region" {
  type = string
  default = "ap-south-1"
}

variable "az-1a" {
  type = string
  default = "ap-south-1a"
}

variable "az-1b" {
  type = string
  default = "ap-south-1b"
}

variable "az-1c" {
  type = string
  default = "ap-south-1c"
}
