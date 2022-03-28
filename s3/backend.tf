terraform {
  backend "s3" {
    bucket = "tf-backend-new"
    key    = "remote.tfstate"
    region = "us-west-2"
  }
}
