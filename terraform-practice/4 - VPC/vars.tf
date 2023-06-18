variable "REGION" {
  default = "us-east-1"
}

variable "ZONE1" {
  default = "us-east-1a"
}

variable "ZONE2" {
  default = "us-east-1b"
}

variable "ZONE3" {
  default = "us-east-1c"
}

variable "AMIS" {
  type = map(any)
  default = {
    us-east-1 = "ami-id"
    us-east-2 = "ami-id"
  }
}

variable "USER" {
  default = "ec2-user"
}

variable "PUB_KEY" {
  default = "vpc-key.pub"
}

variable "PRIV_KEY" {
  default = "vpc-key"
}

variable "MY_IP" {
  default = "Your_IP/32"
}