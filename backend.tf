terraform {
  backend "s3" {
    bucket = "tf-backend-sony"
    key    = "remote.tfstate"
    region = "us-west-2"
  }
}
