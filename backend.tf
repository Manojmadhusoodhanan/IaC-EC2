terraform {
  backend "s3" {
    bucket = "tf-backend-ssunny3"
    key    = "remote.tfstate"
    region = var.region
    encrypt = "true"
  }
}
