
#   uploading the local key to AWS

resource "aws_key_pair" "vpc-key" {
  key_name   = "vpc-key"
  public_key = file(var.PUB_KEY)
}

#   creating the instance

resource "aws_instance" "vpc-instance" {
  ami                    = var.AMIS[var.REGION]
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.peace-pub-1.id
  key_name               = aws_key_pair.vpc-key.key_name
  vpc_security_group_ids = [aws_security_group.peace-sg.id]
  tags = {
    Name = "VPC-Instance"
  }
}

#   creating the EBS Volume

resource "aws_ebs_volume" "peace-vol" {
  availability_zone = var.ZONE1
  size              = 3
  tags = {
    Name = "Peace-Volume"
  }
}

resource "aws_volume_attachment" "peace-vol-atch" {
  device_name = "/dev/xvdh"
  volume_id   = aws_ebs_volume.peace-vol.id
  instance_id = aws_instance.vpc-instance.id
}

output "PublicIP" {
  value = aws_instance.vpc-instance.public_ip
}