resource "aws_s3_bucket" "terraform-crispy-website" {
  bucket = "terraform-crispy-website"

  tags = {
    Name    = "Crispy-Bucket"
    Project = "Crispy"
  }
}