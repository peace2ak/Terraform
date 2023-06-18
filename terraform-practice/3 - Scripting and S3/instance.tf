# defining key-pair for AWS
resource "aws_key_pair" "crispy" {
  key_name   = "crispy-aws"
  public_key = file("crispy-key.pub")
}

# creating an instance
resource "aws_instance" "crispy-instance" {
  ami                    = var.AMIS[var.REGION]
  instance_type          = "t2.micro"
  availability_zone      = var.ZONE1
  key_name               = aws_key_pair.crispy.key_name
  vpc_security_group_ids = [var.SG]
  tags = {
    Name    = "Crispy-Instance"
    Project = "Crispy"
  }

  # uploading web.sh using "file" provisioner 
  provisioner "file" {
    source      = "web.sh"
    destination = "/tmp/web.sh"
  }


  # executing web.sh on ec2-instance
  provisioner "remote-exec" {
    inline = [
      "chmod u+x /tmp/web.sh",
      "sudo /tmp/web.sh"
    ]
  }

  # providing connection details
  connection {
    user        = var.USER
    private_key = file("crispy-key")
    host        = self.public_ip
  }

}



# output public and private ip

output "PublicIP" {
  value = aws_instance.crispy-instance.public_ip
}

output "PrivateIP" {
  value = aws_instance.crispy-instance.private_ip
}
