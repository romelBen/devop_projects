resource "aws_s3_bucket" "example" {
  bucket = "lets-learn-terraform"
  acl = "private"

  tags {
      Name = "Romel I. Benavides"
      Environment = "Dev"
  }
  versioning { 
      enabled = true
  }
}