resource "aws_vpc" "peace" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  tags = {
    Name = "Peace"
  }
}


#   public-subnets

resource "aws_subnet" "peace-pub-1" {
  vpc_id                  = aws_vpc.peace.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = var.ZONE1
  tags = {
    Name = "peace-pub-1"
  }
}

resource "aws_subnet" "peace-pub-2" {
  vpc_id                  = aws_vpc.peace.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = var.ZONE2
  tags = {
    Name = "peace-pub-2"
  }
}

resource "aws_subnet" "peace-pub-3" {
  vpc_id                  = aws_vpc.peace.id
  cidr_block              = "10.0.3.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = var.ZONE3
  tags = {
    Name = "peace-pub-3"
  }
}

#   private-subnets

resource "aws_subnet" "peace-priv-1" {
  vpc_id                  = aws_vpc.peace.id
  cidr_block              = "10.0.4.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = var.ZONE1
  tags = {
    Name = "peace-priv-1"
  }
}

resource "aws_subnet" "peace-priv-2" {
  vpc_id                  = aws_vpc.peace.id
  cidr_block              = "10.0.5.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = var.ZONE2
  tags = {
    Name = "peace-priv-2"
  }
}

resource "aws_subnet" "peace-priv-3" {
  vpc_id                  = aws_vpc.peace.id
  cidr_block              = "10.0.6.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = var.ZONE3
  tags = {
    Name = "peace-priv-3"
  }
}


#   Internet Gateway

resource "aws_internet_gateway" "peace-IGW" {
  vpc_id = aws_vpc.peace.id
  tags = {
    Name = "peace-IGW"
  }
}


#   Joining public-subnet with the internet-gateway
#   Route Table

resource "aws_route_table" "peace-pub-RT" {
  vpc_id = aws_vpc.peace.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.peace-IGW.id
  }
  tags = {
    Name = "peace-pub-RT"
  }
}


#   Associate public-subnet with the route table

resource "aws_route_table_association" "peace-pub-1a" {
  subnet_id      = aws_subnet.peace-pub-1.id
  route_table_id = aws_route_table.peace-pub-RT.id
}

resource "aws_route_table_association" "peace-pub-2b" {
  subnet_id      = aws_subnet.peace-pub-2.id
  route_table_id = aws_route_table.peace-pub-RT.id
}

resource "aws_route_table_association" "peace-pub-3c" {
  subnet_id      = aws_subnet.peace-pub-3.id
  route_table_id = aws_route_table.peace-pub-RT.id
}