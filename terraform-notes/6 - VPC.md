
```markdown
# Exercise 6

Create a new directory and navigate into it:
```bash
mkdir exercise_6
cd exercise_6
```

## Provider Configuration

Create a file called `providers.tf` and specify the AWS provider with the desired region:
```bash
vim providers.tf
```
```tf
provider "aws" {
  region = var.REGION
}
```

## Variables

Create a file called `vars.tf` and define the variables:
```bash
vim vars.tf
```
```tf
variable REGION {
  default = "us-east-2"
}

variable ZONE1 {
  default = "us-east-2a"
}

variable ZONE2 {
  default = "us-east-2b"
}

variable ZONE3 {
  default = "us-east-2c"
}

variable AMIS {
  type = map
  default = {
    us-east-2 = "ami-id"
    us-east-1 = "ami-id"
  }
}

variable USER {
  default = "ec2-user"
}

variable PUB_KEY {
  default = "dovekey.pub"
}

variable PRIV_KEY {
  default = "dovekey"
}

variable MYIP {
  default = "my-public-ip"
}
```

## VPC Resource

Create a file called `vpc.tf` and define the VPC and its subnets:
```bash
vim vpc.tf
```
```tf
resource "aws_vpc" "dove" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "vprofile"
  }
}

resource "aws_subnet" "dove-pub-1" {
  vpc_id                  = aws_vpc.dove.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = var.ZONE1

  tags = {
    Name = "dove-pub-1"
  }
}

# Add similar resource blocks for the remaining subnets
# dove-pub-2, dove-pub-3, dove-priv-1, dove-priv-2, dove-priv-3

resource "aws_internet_gateway" "dove-IGW" {
  vpc_id = aws_vpc.dove.id

  tags = {
    Name = "dove-IGW"
  }
}

resource "aws_route_table" "dove-pub-RT" {
  vpc_id = aws_vpc.dove.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.dove-IGW.id
  }

  tags = {
    Name = "dove-pub-RT"
  }
}

# Add resource blocks for the route table associations

```

## Security Group Resource

Create a file called `secgrp.tf` and define the security group:
```bash
vim secgrp.tf
```
```tf
resource "aws_security_group" "dove_stack_sg" {
  vpc_id        = aws_vpc.dove.id
  name          = "dove-stack-sg"
  description   = "Security group for dove ssh"

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
    cidr_blocks = [var.MYIP]
  }

  tags = {
    Name = "allow-ssh"
  }
}
```

## Backend Configuration

Create a file called `backend.tf` and configure the backend to store the state:
```bash
vim backend.tf
```
```tf
terraform {
  backend "s3" {
    bucket = "terra-state-dove"
    key    = "terraform/backend_exercise_6"
    region = "us-east-2"
  }
}
```

## Shell Script

Create a shell script file called `web.sh`:
```bash
vim web.sh
```
```bash
#!/bin/bash

yum install wget unzip httpd -y
systemctl start httpd
systemctl enable httpd
wget tooplate-url.zip
unzip -o 2117_file_name.zip
cp -r 2117_file_name/* /var/www/html
systemctl restart httpd
```

## Instance Resource

Create a file called `instance.tf` and define the instance resource:
```bash
vim instance.tf
```
```tf
resource "aws_key_pair" "dove-key" {
  key_name   = "dovekey"
  public_key = file("dovekey.pub")
}

resource "aws_instance" "dove-web" {
  ami                    = var.AMIS[var.REGION]
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.dove-pub-1.id
  key_name               = aws_key_pair.dove-key.key_name
  vpc_security_group_ids = [aws_security_group.dove_stack_sg.id]

  tags = {
    Name = "my-dove"
  }
}

# Add resource blocks for EBS volume and volume attachment

output "PublicIP" {
  value = aws_instance.dove-web.public_ip
}
```

## Terraform Commands

Initialize, validate, format, plan, and apply the Terraform configuration:
```bash
terraform init
terraform validate
terraform fmt
terraform plan
terraform apply -auto-approve
```

To destroy the created infrastructure, use the following command:
```bash
terraform destroy -auto-approve
```

Remember to confirm the changes on the AWS Dashboard after applying the Terraform configuration.
```

These notes provide a step-by-step guide for setting up the infrastructure using Terraform. They include the necessary configuration files, commands, and explanations for each section.