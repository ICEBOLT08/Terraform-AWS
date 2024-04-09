provider "aws" {
  region = "eu-central-1"  # Specify your desired AWS region
}

resource "aws_s3_bucket" "TfS3" {
  bucket = "demo-tf-s3"

  tags = {
    Name        = "Terraforms3"
    Environment = "Dev"
  }
}