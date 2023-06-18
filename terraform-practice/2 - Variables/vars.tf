variable "REGION" {
  default = "us-east-1"
}

variable "ZONE1" {
  default = "us-east-1a"
}

variable "SG" {
  default = "sg-id"
}

variable "AMIS" {
  type = map(any)
  default = {
    us-east-1 = "ami-id"
    us-east-2 = "ami-id"
  }
}