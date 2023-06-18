# use this after creating the s3 bucket
# to upload terraform state to s3 bucket
# useful if working in a team

terraform {
  backend "s3" {
    bucket = "terraform-crispy-website" # unique-name of the s3 bucket created
    key    = "terraform/backend"    # name of the folder to be created in s3 bucket
    region = "us-east-1"            # variables are not allowed here
  }
}