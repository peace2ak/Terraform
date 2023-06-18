Here are the concise notes in Markdown format for the provided code:

```markdown
# Terraform

- IAAC | Automate Infrastructure (we can code your infrastructure)
- Define Infrastructure State

- Ansible, puppet, or chef automates mostly OS-related tasks
  - Define machine states (State of OS) (packages, configs)
  - Ansible does not maintain state for cloud automation

- Terraform automates the infrastructure itself
  - Also maintains its state
  - Works with AWS, GCP, Azure, Digital Ocean, etc.

## Use Case

- Terraform works with automation software like Ansible after the infrastructure is set up and ready
- Supports Bash Scripting and PowerShell scripting
- Uses DSL (domain-specific language)
- No programming, its own syntax similar to JSON
- Provides centralized configuration management of your cloud infrastructure

## Installation

- Download the Terraform binary from its website
  - Linux
  - Mac
  - Windows
- Store the binary in an exported PATH (e.g., Linux => /usr/local/bin)

## Exercise 1

1. Launch an EC2 Instance
   - Requires AWS Account
   - IAM user with Access Keys
   - Terraform file to launch an instance
   - Run `terraform apply`
2. Write `instance.tf` file
3. Launch the instance
4. Make some changes to the `instance.tf` file
5. Apply changes and see how Terraform maintains the state

## Lab

Download - .terraform, .awscli

.terraform:
```bash
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform
```

.awscli:
```bash
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
```

IAM > User > Add_user:
- Name: terradmin
- Access_type: Programmatic_Access
- Permissions: AdministratorAccess

AWS-CLI:
```bash
aws configure
# Setup access and secret key
# Region, JSON (output_format)
```

Terraform-CLI:
```bash
terraform --help
mkdir terraform-scripts
cd terraform-scripts
mkdir exercise1
cd exercise1
```

Create `first_instance.tf`:
```tf
provider "aws" {
  region = "us-east-2"
  # access_key = "" - not recommended, as it can be exposed
  # secret_key = "" - better to use it through AWS-CLI
}

resource "aws_instance" "give-resource-name" {
  ami                    = "AMI-ID"
  instance_type          = "t2.micro"
  availability_zone      = "us-east-2a"
  key_name               = "dove-key" # manually create key-pair "dove-key" and add it here
  vpc_security_group_ids = ["sg-id"] # manually create security group "dove-sg"
  tags = {
    Name    = "Dove-Instance"
    Project = "Dove" # add this after running this file once
  }
}
```

Terraform-CLI:
```bash


terraform init # download necessary plugins in CWD
ls -a
ls .terraform/plugins
terraform validate # validate syntax

# To rewrite your code in canonical format
terraform fmt
cat first_instance.tf

# Shows what will happen if executed
terraform plan

# To execute
terraform apply 
yes

# Confirm the changes from the AWS Dashboard

# Add another tag in the `.tf` file and execute again
terraform validate
terraform fmt
terraform plan
terraform apply 
yes

# You can see that Terraform maintains the state of your infrastructure
ls # to see state info
cat terraform.tfstate # current state of EC2 instance in JSON format

# To destroy
terraform destroy
yes
```

**Practice Exercise 1:**

```tf
provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "peace-instance" {
  ami                    = "ami-id"
  instance_type          = "t2.micro"
  availability_zone      = "us-east-1a"
  key_name               = "peace-key"
  vpc_security_group_ids = ["sg-id"]
  tags = {
    Name        = "Peace-Instance"
    Project     = "Peace"
    Team-Leader = "Legend"
  }
}
```

