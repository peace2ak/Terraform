
```markdown
# Variables Use Case

- Move secrets to another file
- Values that change (AMI, tags, key-pair, etc.)
- Reuse your code

## Exercise 2

1. Write `providers.tf` file
2. Write `vars.tf` file
3. Write `instance.tf` file
4. Apply changes
5. Make some changes to `instance.tf` file
6. Apply changes

## Lab

```bash
mkdir exercise_2
cd exercise_2
```

### Variables

Create `vars.tf`:
```tf
variable REGION {
  default = "us-east-2"
}

variable ZONE1 {
  default = "us-east-2a"
}

variable AMIS {
  type = map
  default = {
    us-east-2 = "ami-id"
    us-east-1 = "ami-id"
  }
}
```

Create `providers.tf`:
```tf
provider "aws" {
  region = var.REGION
}
```

Create `instance.tf`:
```tf
resource "aws_instance" "dove-inst" {
  ami                    = var.AMIS[var.REGION]
  instance_type          = "t2.micro"
  availability_zone      = var.ZONE1
  key_name               = "dove-key"
  vpc_security_group_ids = ["sg-id"]
  tags = {
    Name    = "Dove-Instance"
    Project = "Dove"
  }
}
```

Initialize Terraform:
```bash
terraform init
terraform validate
terraform fmt
terraform plan
terraform apply
yes
```

To create a new key-pair "new-dove" and replace the `key_name` in the `instance.tf` file, you need to destroy the current instance and create a new instance using that key-pair:

```bash
terraform destroy
yes
```

