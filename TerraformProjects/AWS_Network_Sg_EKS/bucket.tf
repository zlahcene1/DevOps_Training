terraform {
  backend "s3" {
    bucket  = "ayahyabey-bucket"
    key     = ".terraform.tfstate"
    region  = "eu-central-1"
    encrypt = true
  }
}