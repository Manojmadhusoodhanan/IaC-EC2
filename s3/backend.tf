terraform {
  backend "s3" {
    bucket = "tf-state-backend"
    key    = "remote.tfstate"
    region = "us-west-2"
  }
}
