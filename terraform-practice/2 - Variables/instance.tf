resource "aws_instance" "terra-node" {
  ami                    = var.AMIS[var.REGION]
  instance_type          = "t2.micro"
  availability_zone      = var.ZONE1
  key_name               = "terra-key"
  vpc_security_group_ids = [var.SG]
  tags = {
    Name    = "Terra-Node"
    Project = "Terra-Practice"
  }
}