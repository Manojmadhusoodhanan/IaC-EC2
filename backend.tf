terraform {
  backend "s3" {
    bucket = "tf-backend-ssunny3"
    key    = "remote.tfstate"
    region = "ap-south-1"
    encrypt = "true"
  }
}
