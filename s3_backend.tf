terraform {
  backend "s3" {
    bucket = "praterra"
    region = "us-east-1"
    key    = "terraform.tfstate"

  }
}