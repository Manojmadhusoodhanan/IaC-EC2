variable "cidr" {
  type = list(any)
  default = "10.0.0.0/16"
}

variable "public_cidrs" {
  type = list(any)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_cidrs" {
  type = list(any)
  default = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "az" {
  type = string
  default = ["us-west-2a", "us-west-2b", "us-west-2c", "us-west-2d"]
}
