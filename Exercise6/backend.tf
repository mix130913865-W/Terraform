terraform {
  backend "s3" {
    bucket = "terraformstate98989"
    key    = "terraform/backend"
    region = "us-east-1"
  }
}
