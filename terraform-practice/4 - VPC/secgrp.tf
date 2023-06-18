resource "aws_security_group" "peace-sg" {
  vpc_id      = aws_vpc.peace.id
  name        = "peace-sg"
  description = "Security group to peace ssh"


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.MY_IP]
  }

  tags = {
    Name = "Allow-SSH"
  }
}
