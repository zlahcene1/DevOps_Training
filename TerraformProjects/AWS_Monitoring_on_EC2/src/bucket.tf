terraform {
  backend "s3" {
    bucket  = "s3-src1-grp6"
    key     = ".terraform.tfstate"
    region  = "eu-west-3"
    encrypt = true
  }
}