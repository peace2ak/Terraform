
```markdown
# Provisioners Use Case

- Build Custom Images with tools like Packer
- Use standard Image and use provisioner to set up software and files
  - File uploads
  - remote-exec (execute tasks remotely on EC2 instances)
  - Ansible, Puppet, or Chef

## Provisioner Connection

- Requires connection for provisioning: `ssh-linux` or `winrm-windows`
- SSH provisioner example:
```tf
provisioner "file" {
  source = "file/test.conf"
  destination = "/etc/test.conf"

  connection {
    type = "ssh"
    user = "root"
    password = var.root_password
  }
}
```
- WinRM provisioner example:
```tf
provisioner "file" {
  source = "conf/myapp.conf"
  destination = "C:/App/myapp.conf"

  connection {
    type = "winrm"
    user = "Administrator"
    password = var.admin_password
  }
}
```

## More Provisioners

- The "file" provisioner is used to copy files or directories
- "remote-exec" invokes a command/script on a remote resource
- "local-exec" provisioner invokes a local executable after a resource is created
- The "puppet" provisioner installs, configures, and runs the Puppet agent on a remote resource
- The "chef" provisioner installs, configures, and runs the Chef client on a remote resource
- "Ansible" can be used to run Terraform, output IP address, and run a playbook with "local-exec"

## Exercise 3

1. Generate key-pair
2. Write script
3. Write `providers.tf`
4. Write `vars.tf`
5. Write `instances.tf`
   - Key-pair resource
   - AWS instance resource
     - Provisioners: "file", "remote-exec"
6. Apply changes

## Lab

```bash
mkdir exercise_3
cd exercise_3
ssh-keygen -f dovekey
ls # dovekey, dovekey.pub
```

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

variable USER {
  default = "ec2-user"
}
```

Create `providers.tf`:
```tf
provider "aws" {
  region = var.REGION
}
```

Create `web.sh` script:
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

Create `instance.tf`:
```tf
resource "aws_key_pair" "dove-key" {
  key_name   = "dovekey"
  public_key = file("dovekey.pub")
}

resource "aws_instance" "dove-inst" {
  ami                    = var.AMIS[var.REGION]
  instance_type          = "t2.micro"
  availability_zone      = var.ZONE1
  key_name               = aws_key_pair.dove-key.key_name
  vpc_security_group_ids = ["sg-id"]
  tags = {
    Name    = "Dove-Instance"
    Project = "D

ove"
  }

  provisioner "file" {
    source      = "web.sh"
    destination = "/tmp/web.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod u+x /tmp/web.sh",
      "sudo /tmp/web.sh"
    ]
  }

  connection {
    user        = var.USER
    private_key = file("dovekey")
    host        = self.public_ip
  }
}
```

Initialize and apply changes:
```bash
terraform init
terraform validate
terraform fmt
cat instance.tf
terraform plan
terraform apply
yes
```

To destroy the instance and key-pair:
```bash
terraform destroy
yes
```
