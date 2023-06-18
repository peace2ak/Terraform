provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "terra-ec2" {
  ami                    = "ami-id"
  instance_type          = "t2.micro"
  availability_zone      = "us-east-1b"
  key_name               = "terra-key"
  vpc_security_group_ids = ["sg-id"]
  tags = {
    Name        = "Terra-Instance"
    Project     = "Terra-Practice"
    Description = "1st Terraform Exercise"
  }

}